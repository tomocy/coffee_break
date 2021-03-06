import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/pages/done_links_page.dart';
import 'package:coffee_break/pages/settings_page.dart';
import 'package:coffee_break/pages/today_links_page.dart';
import 'package:coffee_break/pages/todo_links_page.dart';
import 'package:coffee_break/pages/widgets/page_scaffold.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<SettingsBloc>(
        builder: (_, bloc, child) => StreamBuilder<Settings>(
          stream: bloc.settings,
          builder: (_, snapshot) {
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
                routes[PageType.today]: (_) => const TodayLinksPage(),
                routes[PageType.todo]: (_) => const TodoLinksPage(),
                routes[PageType.done]: (_) => const DoneLinksPage(),
                routes[PageType.settings]: (_) => const SettingsPage(),
              },
            );
          },
        ),
        child: Container(),
      );
}
