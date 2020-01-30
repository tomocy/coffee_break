import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class VerbRepository {
  Future<List<Verb>> fetch();
  Future<void> save(Verb verb);
  Future<void> update(Verb oldVerb, Verb newVerb);
  Future<void> delete(Verb verb);
}

class VerbRepositoryFetchException extends VerbRepositoryException {
  const VerbRepositoryFetchException() : super('failed to fetch verbs');
}

class VerbRepositorySaveException extends VerbRepositoryException {
  const VerbRepositorySaveException(this.verb) : super('failed to save verb');

  final Verb verb;
}

class VerbRepositoryUpdateException extends VerbRepositoryException {
  const VerbRepositoryUpdateException(
    this.oldVerb,
    this.newVerb,
  ) : super('failed to update verb');

  final Verb oldVerb;
  final Verb newVerb;
}

class VerbRepositoryDeleteException extends VerbRepositoryException {
  const VerbRepositoryDeleteException(this.verb)
      : super('failed to delete verb');

  final Verb verb;
}

class VerbRepositoryException extends ResourceException {
  const VerbRepositoryException([String message]) : super(message);
}
