import 'dart:async';
import 'package:coffee_break/domain/models/open_graph.dart';
import 'package:coffee_break/domain/resources/open_graph_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenGraphBloc {
  OpenGraphBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
  }

  final OpenGraphRepository _repository;
  final _openGraphController = StreamController<OpenGraph>.broadcast();
  final _fetchController = StreamController<String>();

  Stream<OpenGraph> get openGraph => _openGraphController.stream;

  Sink<String> get fetch => _fetchController.sink;

  Future<void> _invokeFetch(String uri) async {
    try {
      final openGraph = await _repository.fetch(uri);
      _openGraphController.add(openGraph);
    } on OpenGraphRepositoryFetchException catch (e) {
      _openGraphController.addError(e);
    }
  }

  void dispose() {
    _openGraphController.close();
    _fetchController.close();
  }
}
