import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_break/pages/links_page.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/settings_page.dart';
import 'package:coffee_break/theme.dart' as theme;

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Settings()),
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
