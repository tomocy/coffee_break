import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {
  var _settings = Settings();

  @override
  Future<Settings> fetch() async =>
      !doFail ? _settings : throw const SettingsRepositoryFetchException();

  @override
  Future<void> save(Settings settings) async => !doFail
      ? _settings = settings
      : throw const SettingsRepositorySaveException();
}
