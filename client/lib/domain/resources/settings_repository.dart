import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/resource.dart';

abstract class SettingsRepository {
  Future<Settings> fetch();

  Future<void> save(Settings settings);
}

class SettingsRepositoryFetchException extends SettingsRepositoryException {
  SettingsRepositoryFetchException() : super('failed to fetch settings');
}

class SettingsRepositorySaveException extends SettingsRepositoryException {
  SettingsRepositorySaveException() : super('failed to save settings');
}

class SettingsRepositoryException extends ResourceException {
  const SettingsRepositoryException([String message]) : super(message);
}
