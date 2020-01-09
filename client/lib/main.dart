import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './page/page.dart';
import './page/settings_page.dart';
import './theme.dart' as theme;

void main() => runApp(ChangeNotifierProvider(
      create: (context) => Settings(),
      child: const App(),
    ));

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        themeMode: Provider.of<Settings>(context).themeMode,
        theme: theme.light(),
        darkTheme: theme.dark(),
        initialRoute: routes[PageType.home],
        routes: {
          routes[PageType.home]: (context) => Page(
                type: PageType.home,
                title: 'Home',
                body: Container(),
              ),
          routes[PageType.settings]: (context) => const Page(
                type: PageType.settings,
                title: 'Settings',
                body: SettingsPage(),
              ),
        },
      );
}
