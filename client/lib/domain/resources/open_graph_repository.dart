import 'package:coffee_break/domain/models/open_graph.dart';
import 'package:coffee_break/domain/resources/resource.dart';

// ignore: one_member_abstracts
abstract class OpenGraphRepository {
  Future<OpenGraph> fetch(String uri);
}

class OpenGraphRepositoryFetchException extends OpenGraphRepositoryException {
  const OpenGraphRepositoryFetchException()
      : super('failed to fetch open graph');
}

class OpenGraphRepositoryException extends ResourceException {
  const OpenGraphRepositoryException([String message]) : super(message);
}
