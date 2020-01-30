import 'package:coffee_break/domain/models/open_graph.dart';
import 'package:coffee_break/domain/resources/open_graph_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockOpenGraphRepository extends Mock implements OpenGraphRepository {
  final _openGraphs = <String, OpenGraph>{
    'https://github.com': const OpenGraph(title: 'GitHub'),
    'https://twitter.com':
        const OpenGraph(title: "Twitter. It's what's happening."),
  };

  @override
  Future<OpenGraph> fetch(String uri) async => !doFail
      ? _openGraphs[uri]
      : throw const OpenGraphRepositoryFetchException();
}
