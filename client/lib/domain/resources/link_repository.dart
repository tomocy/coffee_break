import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class LinkRepository {
  Future<List<Link>> fetch();
  Future<void> save(Link link);
  Future<void> delete(Link link);
}

class LinkRepositoryFetchException extends LinkRepositoryException {
  LinkRepositoryFetchException([String message]) : super(message);
}

class LinkRepositorySaveException extends LinkRepositoryException {
  LinkRepositorySaveException([String message]) : super(message);
}

class LinkRepositoryDeleteException extends LinkRepositoryException {
  LinkRepositoryDeleteException([String message]) : super(message);
}

class LinkRepositoryException extends ResourceException {
  const LinkRepositoryException([String message]) : super(message);
}
