import 'dart:async';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/page/links_page.dart';

class LinkRepositoryBloc {
  LinkRepositoryBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
  }

  final LinkRepository _repository;
  final _linksController = StreamController<List<Link>>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<void>.broadcast();
  final _saveController = StreamController<Link>();

  Stream<List<Link>> get links => _linksController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Stream<void> get saved => _savedController.stream;

  Sink<Link> get save => _saveController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final links = await _repository.fetch();
      _linksController.add(links);
    } on LinkRepositoryFetchException catch (e) {
      _linksController.addError(e);
    }
  }

  Future<void> _invokeSave(Link link) async {
    try {
      await _repository.save(link);
    } on LinkRepositorySaveException catch (e) {
      _savedController.addError(e);
    }
  }

  void dispose() {
    _linksController.close();
    _savedController.close();
    _fetchController.close();
    _saveController.close();
  }
}
