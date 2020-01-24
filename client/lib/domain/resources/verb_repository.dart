import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class VerbRepository {
  Future<List<Verb>> fetch();
  Future<void> save(Verb verb);
  Future<void> update(Verb oldVerb, Verb newVerb);
  Future<void> delete(Verb verb);
}

class VerbRepositoryFetchException extends VerbRepositoryException {
  const VerbRepositoryFetchException([String message]) : super(message);
}

class VerbRepositorySaveException extends VerbRepositoryException {
  const VerbRepositorySaveException(
    this.verb, [
    String message,
  ]) : super(message);

  final Verb verb;
}

class VerbRepositoryUpdateException extends VerbRepositoryException {
  const VerbRepositoryUpdateException(
    this.oldVerb,
    this.newVerb, [
    String message,
  ]) : super(message);

  final Verb oldVerb;
  final Verb newVerb;
}

class VerbRepositoryDeleteException extends VerbRepositoryException {
  const VerbRepositoryDeleteException(
    this.verb, [
    String message,
  ]) : super(message);

  final Verb verb;
}

class VerbRepositoryException extends ResourceException {
  const VerbRepositoryException([String message]) : super(message);
}
