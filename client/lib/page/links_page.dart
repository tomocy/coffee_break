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
        create: (context) => LinksRepository(fetch: fetch)..invokeFetch(),
        child: Consumer<LinksRepository>(
          builder: (context, repository, child) {
            if (repository.status == LinksRepositoryStatus.succeeded) {
              return ListView.builder(
                itemCount: repository.links.length,
                itemBuilder: (context, i) =>
                    LinksListTile(title: repository.links[i]),
              );
            }

            if (repository.status == LinksRepositoryStatus.failed) {
              WidgetsBinding.instance
                  .addPostFrameCallback((duration) => Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(repository.error.toString()),
                      action: SnackBarAction(
                        label: 'RETRY',
                        onPressed: () => repository.invokeFetch(),
                      ),
                    )));
            }

            return child;
          },
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
}

class LinksListTile extends StatelessWidget {
  const LinksListTile({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title),
      );
}

class LinksRepository extends ChangeNotifier {
  LinksRepository({@required this.fetch}) : assert(fetch != null);

  final Fetch fetch;
  LinksRepositoryStatus _status;
  List<String> _links;
  LinksRepositoryException _error;

  LinksRepositoryStatus get status => _status;
  List<String> get links => _links;
  LinksRepositoryException get error => _error;

  Future<void> invokeFetch() async {
    if (status == LinksRepositoryStatus.waiting) {
      return;
    }

    _changeStatus(LinksRepositoryStatus.waiting);

    try {
      _links = await fetch();
      _changeStatus(LinksRepositoryStatus.succeeded);
    } on FetchException catch (e) {
      _error = e;
      _changeStatus(LinksRepositoryStatus.failed);
    }
  }

  void _changeStatus(LinksRepositoryStatus status) {
    _status = status;
    notifyListeners();
  }
}

typedef Fetch = Future<List<String>> Function();

enum LinksRepositoryStatus { waiting, succeeded, failed }

class FetchException implements LinksRepositoryException {}

class LinksRepositoryException implements Exception {}
