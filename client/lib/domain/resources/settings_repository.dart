import 'package:coffee_break/domain/models/settings.dart';

abstract class SettingsRepositoory {
  Future<Settings> fetch();

  Future<void> save(Settings settings);
}

class SettingsRepositoryFetchException extends SettingsRepositoryException {
  SettingsRepositoryFetchException([String message]) : super(message);
}

class SettingsRepositorySaveException extends SettingsRepositoryException {
  SettingsRepositorySaveException([String message]) : super(message);
}

class SettingsRepositoryException implements Exception {
  const SettingsRepositoryException([this.message]);

  final String message;
}
