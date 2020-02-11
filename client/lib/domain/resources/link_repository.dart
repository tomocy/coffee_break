import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class LinkRepository {
  Future<List<Link>> fetch();
  Future<void> save(Link link);
  Future<void> update(Link oldLink, Link newLink);
  Future<void> delete(Link link);
}

class LinkRepositoryFetchException extends LinkRepositoryException {
  const LinkRepositoryFetchException() : super('failed to fetch links');
}

class LinkRepositoryUpdateException extends LinkRepositoryException {
  const LinkRepositoryUpdateException(
    this.oldLink,
    this.newLink,
  ) : super('failed to update link');

  final Link oldLink;
  final Link newLink;
}

class LinkRepositorySaveException extends LinkRepositoryException {
  const LinkRepositorySaveException(this.link) : super('failed to save link');

  final Link link;
}

class LinkRepositoryDeleteException extends LinkRepositoryException {
  const LinkRepositoryDeleteException(this.link)
      : super('failed to delete link');

  final Link link;
}

class LinkRepositoryException extends ResourceException {
  const LinkRepositoryException([String message]) : super(message);
}
