import 'dart:math';

import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';

class MockSettingsRepository implements SettingsRepository {
  var _settings = Settings();
  var _random = Random();

  @override
  Future<Settings> fetch() async => _random.nextBool()
      ? _settings
      : throw SettingsRepositoryFetchException('failed to fetch settings.');

  @override
  Future<void> save(Settings settings) async => _random.nextBool()
      ? _settings = settings
      : throw SettingsRepositorySaveException('failed to save settings.');
}
