import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Page(
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
                children: <Widget>[
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
