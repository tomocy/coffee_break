import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {
  MockSettingsRepository({Failer failer, this.settings})
      : super(failer: failer) {
    settings ??= Settings();
  }

  Settings settings;

  @override
  Future<Settings> fetch() async =>
      !doFail ? settings : throw const SettingsRepositoryFetchException();

  @override
  Future<void> save(Settings settings) async => !doFail
      ? this.settings = settings
      : throw const SettingsRepositorySaveException();
}
