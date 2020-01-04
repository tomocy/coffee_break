import 'dart:math';
import 'package:flutter/material.dart';
import './page.dart';
import './theme.dart' as theme;

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: theme.light(),
        darkTheme: theme.dark(),
        initialRoute: routes[PageType.home],
        routes: {
          routes[PageType.home]: (context) => const Page(
                type: PageType.home,
                title: 'Home',
                body: LinksPage(fetch: _fetchMock),
              ),
          routes[PageType.read]: (context) => const Page(
                type: PageType.read,
                title: 'Read',
                body: LinksPage(fetch: _fetchMock),
              ),
        },
      );
}

Future<List<String>> _fetchMock() async => Future.delayed(
      const Duration(seconds: 1),
      () => Random().nextBool()
          ? List.generate(100, (i) => 'List $i')
          : throw FetchException(),
    );
