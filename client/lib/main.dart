import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './page/links_page.dart';
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
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LinksRepository(fetch: _fetchMock)..invokeFetch(),
        child: MaterialApp(
          themeMode: Provider.of<Settings>(context).themeMode,
          theme: theme.light(),
          darkTheme: theme.dark(),
          initialRoute: routes[PageType.home],
          routes: {
            routes[PageType.home]: (context) => const Page(
                  type: PageType.home,
                  title: 'Home',
                  body: LinksPage(),
                ),
            routes[PageType.read]: (context) => const Page(
                  type: PageType.read,
                  title: 'Read',
                  body: LinksPage(),
                ),
            routes[PageType.settings]: (context) => const Page(
                  type: PageType.settings,
                  title: 'Settings',
                  body: SettingsPage(),
                ),
          },
        ),
      );
}

Future<List<Link>> _fetchMock() async => Future.delayed(
      const Duration(seconds: 1),
      () => Random().nextBool()
          ? List.generate(100, (i) => Link(uri: 'List $i'))
          : throw FetchException(),
    );
