import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class VerbRepository {
  Future<List<Verb>> fetch();
  Future<void> save();
}

class VerbRepositoryFetchException extends VerbRepositoryException {
  const VerbRepositoryFetchException([String message]) : super(message);
}

class VerbRepositorySaveException extends VerbRepositoryException {
  const VerbRepositorySaveException([String message]) : super(message);
}

class VerbRepositoryException extends ResourceException {
  const VerbRepositoryException([String message]) : super(message);
}
