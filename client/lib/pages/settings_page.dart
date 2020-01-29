import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/pages/widgets/page_scaffold.dart';
import 'package:coffee_break/pages/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PageScaffold(
        type: PageType.settings,
        title: 'Settings',
        body: Consumer<SettingsBloc>(
          builder: (_, bloc, child) => StreamBuilder<Settings>(
            stream: bloc.settings,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                bloc.notify.add(null);
                return child;
              }

              return ListView(
                children: [
                  SettingTile(
                    title: 'Theme',
                    onChanged: (theme) {
                      snapshot.data.themeMode = themes.entries
                          .firstWhere(
                            (entry) => entry.value == theme,
                            orElse: () => MapEntry(
                              snapshot.data.themeMode,
                              themes[snapshot.data.themeMode],
                            ),
                          )
                          .key;
                      bloc.save.add(snapshot.data);
                    },
                    selectedItem: themes[snapshot.data.themeMode],
                    items: themes.values.toList(),
                  ),
                ],
              );
            },
          ),
          child: Container(),
        ),
      );
}
