import 'package:coffee_break/app.dart';
import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';
import 'package:coffee_break/infra/link_repository.dart';
import 'package:coffee_break/infra/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        Provider<SettingsRepository>(
          create: (_) => MockSettingsRepository(),
        ),
        Provider<SettingsBloc>(
          create: (context) => SettingsBloc(Provider.of<SettingsRepository>(
            context,
            listen: false,
          )),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<LinkRepository>(
          create: (_) => MockLinkRepository(),
        ),
        Provider<LinkBloc>(
          create: (context) => LinkBloc(Provider.of<LinkRepository>(
            context,
            listen: false,
          ))
            ..fetch.add(null),
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: const App(),
    ));
