import 'dart:async';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';

class SettingsBloc {
  SettingsBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
  }

  final SettingsRepository _repository;
  final _settingsController = StreamController<Settings>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<void>.broadcast();
  final _saveController = StreamController<Settings>();

  Stream<Settings> get settings => _settingsController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Stream<void> get saved => _savedController.stream;

  Sink<Settings> get save => _saveController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final settings = await _repository.fetch();
      _settingsController.add(settings);
    } on SettingsRepositoryFetchException catch (e) {
      _settingsController.add(Settings());
    }
  }

  Future<void> _invokeSave(Settings settings) async {
    try {
      await _repository.save(settings);
    } on SettingsRepositorySaveException catch (e) {
      _savedController.addError(e);
    }
  }

  void dispose() {
    _settingsController.close();
    _fetchController.close();
    _savedController.close();
    _saveController.close();
  }
}
