import 'dart:async';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/domain/models/link.dart';

class LinkBloc {
  LinkBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
    _searchController.stream.listen(_invokeSearch);
    _notifyController.stream.listen(_invokeNotify);
  }

  final LinkRepository _repository;
  final _links = <Link>[];
  final _linksController = StreamController<List<Link>>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<bool>.broadcast();
  final _saveController = StreamController<Link>();
  final _searchedLinksController = StreamController<List<Link>>.broadcast();
  final _searchController = StreamController<String>();
  final _notifyController = StreamController<void>();

  Stream<List<Link>> get links => _linksController.stream;

  Stream<List<Link>> get todoLinks =>
      links.map((links) => links.where((link) => !link.isDone).toList());

  Stream<List<Link>> get doneLinks =>
      links.map((links) => links.where((links) => links.isDone).toList());

  Sink<void> get fetch => _fetchController.sink;

  Stream<bool> get saved => _savedController.stream;

  Sink<Link> get save => _saveController.sink;

  Stream<List<Link>> get searchedLinks => _searchedLinksController.stream;

  Sink<String> get search => _searchController.sink;

  Sink<void> get notify => _notifyController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final links = await _repository.fetch();
      _links
        ..clear()
        ..addAll(links);
      _invokeNotify(null);
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
      _savedController.add(true);
      _invokeNotify(null);
    } on LinkRepositorySaveException catch (e) {
      _savedController.addError(e);
    }
  }

  void _invokeSearch(String query) {
    _searchedLinksController.add(
      _links
          .where((link) =>
              query.isNotEmpty &&
              link.uri.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  void _invokeNotify(void _) => _linksController.add(_links);

  void dispose() {
    _linksController.close();
    _savedController.close();
    _fetchController.close();
    _saveController.close();
    _searchedLinksController.close();
    _searchController.close();
    _notifyController.close();
  }
}
