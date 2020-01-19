import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';

class MockSettingsRepository implements SettingsRepository {
  var _settings = Settings();

  @override
  Future<Settings> fetch() async => _settings;

  @override
  Future<void> save(Settings settings) async => _settings = settings;
}
