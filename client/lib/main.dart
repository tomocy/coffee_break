import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/domain/resources/settings_repository.dart';
import 'package:coffee_break/infra/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_break/pages/links_page.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/settings_page.dart';
import 'package:coffee_break/theme.dart' as theme;

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
        ChangeNotifierProvider(create: (context) => Links()),
      ],
      child: const App(),
    ));

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        themeMode: Provider.of<Settings>(context).themeMode,
        theme: theme.light(),
        darkTheme: theme.dark(),
        initialRoute: routes[PageType.unread],
        routes: {
          routes[PageType.unread]: (context) => const Page(
                type: PageType.unread,
                title: 'Unread',
                body: UnreadLinksPage(),
              ),
          routes[PageType.read]: (context) => const Page(
                type: PageType.read,
                title: 'Read',
                body: ReadLinksPage(),
              ),
          routes[PageType.settings]: (context) => const Page(
                type: PageType.settings,
                title: 'Settings',
                body: SettingsPage(),
              ),
        },
      );
}
