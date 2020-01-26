import 'dart:async';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';

class VerbBloc {
  VerbBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
    _updateController.stream.listen(_invokeUpdate);
    _deleteController.stream.listen(_invokeDelete);
    _searchController.stream.listen(_invokeSearch);
    _notifyController.stream.listen(_invokeNotify);
  }

  final VerbRepository _repository;
  final List<Verb> _verbs = [];
  final _verbsController = StreamController<List<Verb>>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<bool>.broadcast();
  final _saveController = StreamController<Verb>();
  final _updatedController = StreamController<bool>.broadcast();
  final _updateController = StreamController<UpdateVerbEvent>();
  final _deletedController = StreamController<bool>.broadcast();
  final _deleteController = StreamController<Verb>();
  final _searchedVerbsController = StreamController<List<Verb>>.broadcast();
  final _searchController = StreamController<String>();
  final _notifyController = StreamController<void>();

  Stream<List<Verb>> get verbs => _verbsController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Stream<bool> get saved => _savedController.stream;

  Sink<Verb> get save => _saveController.sink;

  Stream<bool> get updated => _updatedController.stream;

  Sink<UpdateVerbEvent> get update => _updateController.sink;

  Stream<bool> get deleted => _deletedController.stream;

  Sink<Verb> get delete => _deleteController.sink;

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

  Future<void> _invokeUpdate(UpdateVerbEvent event) async {
    if (event.oldVerb == event.newVerb) {
      return;
    }

    try {
      await _repository.update(event.oldVerb, event.newVerb);
      _verbs
        ..remove(event.oldVerb)
        ..add(event.newVerb);

      _updatedController.add(true);
      _invokeNotify(null);
    } on VerbRepositoryUpdateException catch (e) {
      _updatedController.addError(e);
    }
  }

  Future<void> _invokeDelete(Verb verb) async {
    try {
      await _repository.delete(verb);
      _verbs.remove(verb);

      _deletedController.add(true);
      _invokeNotify(null);
    } on VerbRepositoryDeleteException catch (e) {
      _deletedController.addError(e);
    }
  }

  void _invokeSearch(String query) => _searchedVerbsController.add(
        _verbs
            .where(
                (verb) => verb.base.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );

  void _invokeNotify(void _) => _verbsController.add(_verbs);

  void dispose() {
    _verbsController.close();
    _fetchController.close();
    _savedController.close();
    _saveController.close();
    _updatedController.close();
    _updateController.close();
    _deletedController.close();
    _deleteController.close();
    _searchedVerbsController.close();
    _searchController.close();
    _notifyController.close();
  }
}

class UpdateVerbEvent {
  const UpdateVerbEvent({
    this.oldVerb,
    this.newVerb,
  });

  final Verb oldVerb;
  final Verb newVerb;
}
