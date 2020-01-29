import 'package:coffee_break/domain/models/open_graph.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class OpenGraphRepository {
  Future<OpenGraph> fetch(String uri);
}

class OpenGraphRepositoryFetchException extends OpenGraphRepositoryException {
  const OpenGraphRepositoryFetchException([String message]) : super(message);
}

class OpenGraphRepositoryException extends ResourceException {
  const OpenGraphRepositoryException([String message]) : super(message);
}
