import 'package:coffee_break/domain/models/link.dart';

abstract class LinkRepository {
  Future<List<Link>> fetch();
  Future<void> save(Link link);
}

class LinkRepositoryFetchException extends LinkRepositoryException {
  LinkRepositoryFetchException([String message]) : super(message);
}

class LinkRepositorySaveException extends LinkRepositoryException {
  LinkRepositorySaveException([String message]) : super(message);
}

class LinkRepositoryException implements Exception {
  const LinkRepositoryException([this.message]);

  final String message;
}
