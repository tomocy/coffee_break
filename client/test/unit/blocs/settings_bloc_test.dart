import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/infra/settings_repository.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() => group('SettingsBloc test', () {
      group('fetch', () {
        test('success', () async {
          final expected = Settings();
          final repository = MockSettingsRepository(
            settings: expected,
          );
          final bloc = SettingsBloc(repository);

          bloc.fetch.add(null);
          await expectLater(
            bloc.settings,
            emits(expected),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final expected = Settings();
          final repository = MockSettingsRepository(
            failer: () => true,
          );
          final bloc = SettingsBloc(repository);

          bloc.fetch.add(null);
          await expectLater(
            bloc.settings,
            emits(expected),
          );
          bloc.dispose();
        });
      });

      group('save', () {
        test('success', () async {
          final expected = Settings(
            themeMode: ThemeMode.dark,
          );
          final repository = MockSettingsRepository();
          final bloc = SettingsBloc(repository);

          bloc.save.add(expected);
          await expectLater(
            bloc.settings,
            emits(expected),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final expected = Settings(
            themeMode: ThemeMode.dark,
          );
          final repository = MockSettingsRepository(
            failer: () => true,
          );
          final bloc = SettingsBloc(repository);

          bloc.save.add(expected);
          await expectLater(
            bloc.settings,
            emits(expected),
          );
          bloc.dispose();
        });
      });
    });
