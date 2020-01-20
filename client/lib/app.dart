import 'package:coffee_break/blocs/settings_bloc.dart';
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
  Widget build(BuildContext context) => Consumer<SettingsBloc>(
        builder: (_, bloc, child) => StreamBuilder<Settings>(
          stream: bloc.settings,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              bloc.fetch.add(null);
              return child;
            }

            return MaterialApp(
              themeMode: snapshot.data.themeMode,
              theme: light(),
              darkTheme: dark(),
              initialRoute: routes[PageType.todo],
              routes: {
                routes[PageType.todo]: (context) => const Page(
                      type: PageType.todo,
                      title: 'Todo',
                      body: TodoLinksPage(),
                    ),
                routes[PageType.done]: (context) => const Page(
                      type: PageType.done,
                      title: 'Done',
                      body: DoneLinksPage(),
                    ),
                routes[PageType.settings]: (context) => const Page(
                      type: PageType.settings,
                      title: 'Settings',
                      body: SettingsPage(),
                    ),
              },
            );
          },
        ),
        child: Container(),
      );
}
