import 'package:coffee_break/app.dart';
import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/links.dart';
import 'package:coffee_break/domain/models/settings.dart';
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
        FutureProvider<Settings>(
          create: (context) async {
            final bloc = Provider.of<SettingsBloc>(
              context,
              listen: false,
            );
            bloc.fetch.add(null);
            return bloc.settings.first;
          },
          initialData: Settings(),
        ),
        ChangeNotifierProvider<Settings>(
          create: (context) => Provider.of<Settings>(
            context,
            listen: false,
          ),
        ),
        Provider<LinkRepository>(
          create: (_) => MockLinkRepository(),
        ),
        Provider<LinkBloc>(
          create: (context) => LinkBloc(Provider.of<LinkRepository>(
            context,
            listen: false,
          )),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        StreamProvider<List<Link>>(
          create: (context) {
            final bloc = Provider.of<LinkBloc>(
              context,
              listen: false,
            );
            bloc.fetch.add(null);
            return bloc.links;
          },
          initialData: const [],
          catchError: (_, __) => const [],
        ),
        ChangeNotifierProvider<Links>(
          create: (context) => Links(Provider.of<List<Link>>(
            context,
            listen: false,
          )),
        ),
      ],
      child: const App(),
    ));
