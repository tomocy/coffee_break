import 'dart:async';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/domain/models/link.dart';

class LinkBloc {
  LinkBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
    _filterController.stream.listen(_invokeFilter);
  }

  final LinkRepository _repository;
  final _links = <Link>[];
  final _linksController = StreamController<List<Link>>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<void>.broadcast();
  final _saveController = StreamController<Link>();
  final _filteredLinksController = StreamController<List<Link>>.broadcast();
  final _filterController = StreamController<String>();

  Stream<List<Link>> get links => _linksController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Stream<void> get saved => _savedController.stream;

  Sink<Link> get save => _saveController.sink;

  Stream<List<Link>> get filteredLinks => _filteredLinksController.stream;

  Sink<String> get filter => _filterController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final links = await _repository.fetch();
      _links
        ..clear()
        ..addAll(links);
      _linksController.add(links);
      print(_links);
    } on LinkRepositoryFetchException catch (e) {
      _linksController.addError(e);
    }
  }

  Future<void> _invokeSave(Link link) async {
    try {
      await _repository.save(link);
      _links
        ..remove(link)
        ..add(link);
    } on LinkRepositorySaveException catch (e) {
      _savedController.addError(e);
    }
  }

  void _invokeFilter(String query) {
    _filteredLinksController.add(
      _links
          .where((link) =>
              query.isNotEmpty &&
              link.uri.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  void dispose() {
    _linksController.close();
    _savedController.close();
    _fetchController.close();
    _saveController.close();
    _filteredLinksController.close();
    _filterController.close();
  }
}
