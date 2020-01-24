import 'dart:async';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';

class VerbBloc {
  VerbBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
    _searchController.stream.listen(_invokeSearch);
    _notifyController.stream.listen(_invokeNotify);
  }

  final VerbRepository _repository;
  final List<Verb> _verbs = [];
  final _verbsController = StreamController<List<Verb>>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<bool>.broadcast();
  final _saveController = StreamController<Verb>();
  final _searchedVerbsController = StreamController<List<Verb>>.broadcast();
  final _searchController = StreamController<String>();
  final _notifyController = StreamController<void>();

  Stream<List<Verb>> get verbs => _verbsController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Stream<bool> get saved => _savedController.stream;

  Sink<Verb> get save => _saveController.sink;

  Stream<List<Verb>> get searchedVerbs => _searchedVerbsController.stream;

  Sink<String> get search => _searchController.sink;

  Sink<void> get notify => _notifyController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final verbs = await _repository.fetch();
      _verbs
        ..clear()
        ..addAll(verbs);

      _invokeNotify(null);
    } on VerbRepositoryFetchException catch (e) {
      _verbsController.addError(e);
    }
  }

  Future<void> _invokeSave(Verb verb) async {
    try {
      await _repository.save(verb);
      _verbs
        ..remove(verb)
        ..add(verb);

      _savedController.add(true);
      _invokeNotify(null);
    } on VerbRepositorySaveException catch (e) {
      _savedController.addError(e);
    }
  }

  void _invokeSearch(String query) => _searchedVerbsController.add(
        _verbs
            .where((verb) =>
                query.isNotEmpty &&
                verb.base.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );

  void _invokeNotify(void _) => _verbsController.add(_verbs);

  void dispose() {
    _verbsController.close();
    _fetchController.close();
    _savedController.close();
    _saveController.close();
    _searchedVerbsController.close();
    _searchController.close();
    _notifyController.close();
  }
}
