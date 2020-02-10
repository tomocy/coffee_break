import 'package:coffee_break/domain/models/open_graph.dart';
import 'package:coffee_break/domain/resources/open_graph_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockOpenGraphRepository extends Mock implements OpenGraphRepository {
  MockOpenGraphRepository({
    Failer failer,
    this.openGraphs = const <String, OpenGraph>{
      'https://github.com': OpenGraph(title: 'GitHub'),
      'https://twitter.com':
          OpenGraph(title: "Twitter. It's what's happening."),
    },
  }) : super(failer: failer);

  final Map<String, OpenGraph> openGraphs;

  @override
  Future<OpenGraph> fetch(String uri) async => !doFail
      ? openGraphs[uri]
      : throw const OpenGraphRepositoryFetchException();
}
