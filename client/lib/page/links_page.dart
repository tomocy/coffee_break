import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinksRepository>(
        builder: (context, repository, child) {
          if (repository.status == LinksRepositoryStatus.successed) {
            return ListView.builder(
              itemCount: repository.links.length,
              itemBuilder: (context, i) =>
                  LinksListTile(link: repository.links[i]),
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
      );
}

class LinksListTile extends StatelessWidget {
  const LinksListTile({
    Key key,
    this.link,
  }) : super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(link.uri),
      );
}

class LinksRepository extends ChangeNotifier {
  LinksRepository({@required this.fetch}) : assert(fetch != null);

  final Fetch fetch;
  LinksRepositoryStatus _status;
  List<Link> _links;
  LinksRepositoryException _error;

  LinksRepositoryStatus get status => _status;
  List<Link> get links => _links;
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

typedef Fetch = Future<List<Link>> Function();

enum LinksRepositoryStatus { waiting, succeeded, failed }

class FetchException implements LinksRepositoryException {}

class LinksRepositoryException implements Exception {}

class Link {
  const Link({@required this.uri}) : assert(uri != null);

  final String uri;
}
