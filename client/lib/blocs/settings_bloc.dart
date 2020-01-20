import 'dart:async';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';

class SettingsBloc {
  SettingsBloc(this._repository) {
    _fetchController.stream.listen(_invokeFetch);
    _saveController.stream.listen(_invokeSave);
    _notifyController.stream.listen(_invokeNotify);
  }

  final SettingsRepository _repository;
  var _settings = Settings();
  final _settingsController = StreamController<Settings>.broadcast();
  final _fetchController = StreamController<void>();
  final _savedController = StreamController<void>.broadcast();
  final _saveController = StreamController<Settings>();
  final _notifyController = StreamController<void>();

  Stream<Settings> get settings => _settingsController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Stream<void> get saved => _savedController.stream;

  Sink<Settings> get save => _saveController.sink;

  Sink<void> get notify => _notifyController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      _settings = await _repository.fetch();
    } on SettingsRepositoryFetchException {
      _settings ??= Settings();
    } finally {
      _invokeNotify(null);
    }
  }

  Future<void> _invokeSave(Settings settings) async {
    try {
      await _repository.save(settings);
    } on SettingsRepositorySaveException catch (e) {
      _savedController.addError(e);
    } finally {
      _settings = settings;
      _invokeNotify(null);
    }
  }

  void _invokeNotify(void _) => _settingsController.add(_settings);

  void dispose() {
    _settingsController.close();
    _fetchController.close();
    _savedController.close();
    _saveController.close();
    _notifyController.close();
  }
}
