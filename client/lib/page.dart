import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const routes = <PageType, String>{
  PageType.home: '/home',
  PageType.read: '/read',
};

enum PageType { home, read }

class Page extends StatelessWidget {
  const Page({
    Key key,
    @required this.type,
    @required this.title,
    @required this.fetch,
  })  : assert(type != null),
        assert(title != null),
        assert(fetch != null),
        super(key: key);

  final PageType type;
  final String title;
  final Fetch fetch;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  right:
                      BorderSide(color: Theme.of(context).colorScheme.surface)),
            ),
            child: ListView(children: <Widget>[
              ListTile(
                title: const Text('Home'),
                onTap: () => type == PageType.home
                    ? Navigator.pop(context)
                    : Navigator.pushNamed(
                        context,
                        routes[PageType.home],
                      ),
              ),
              ListTile(
                title: const Text('Read'),
                onTap: () => type == PageType.read
                    ? Navigator.pop(context)
                    : Navigator.pushNamed(
                        context,
                        routes[PageType.read],
                      ),
              ),
            ]),
          ),
        ),
        drawerScrimColor: Colors.black12,
        body: ChangeNotifierProvider<LinksRepository>(
          create: (context) => LinksRepository(fetch)..invoke(),
          child: const LinksListView(),
        ),
      );
}

class LinksListView extends StatelessWidget {
  const LinksListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinksRepository>(
        builder: (context, repository, child) {
          if (repository.status == FetchStatus.fetched) {
            return ListView.builder(
              itemCount: repository.links.length,
              itemBuilder: (context, i) =>
                  ListTile(title: Text(repository.links[i])),
            );
          }

          if (repository.status == FetchStatus.failed) {
            WidgetsBinding.instance
                .addPostFrameCallback((duration) => Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(repository.error.toString()),
                    action: SnackBarAction(
                      label: 'Refetch',
                      onPressed: () => repository.invoke(),
                    ),
                  )));
          }

          return child;
        },
        child: const Center(child: CircularProgressIndicator()),
      );
}

class LinksRepository extends ChangeNotifier {
  LinksRepository(this.fetch);

  final Fetch fetch;
  FetchStatus _status;
  List<String> _links;
  FetchException _error;

  FetchStatus get status => _status;
  List<String> get links => _links;
  FetchException get error => _error;

  Future<void> invoke() async {
    if (status == FetchStatus.fetching) {
      return;
    }

    _changeStatus(FetchStatus.fetching);

    try {
      _links = await fetch();
      _changeStatus(FetchStatus.fetched);
    } on FetchException catch (e) {
      _error = e;
      _changeStatus(FetchStatus.failed);
    }
  }

  void _changeStatus(FetchStatus status) {
    _status = status;
    notifyListeners();
  }
}

typedef Fetch = Future<List<String>> Function();

enum FetchStatus { fetching, fetched, failed }

class FetchException implements Exception {}
