import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/pages/links_page.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/settings_page.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        themeMode: Provider.of<Settings>(context).themeMode,
        theme: light(),
        darkTheme: dark(),
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
