import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({
    Key key,
    this.fetch,
  })  : assert(fetch != null),
        super(key: key);

  final Fetch fetch;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<LinksRepository>(
        create: (context) => LinksRepository(fetch)..invoke(),
        child: const LinksListView(),
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
