import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:coffee_break/pages/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<SettingsBloc>(
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
                    final newThemeMode = themes.entries
                        .firstWhere((entry) => entry.value == theme)
                        .key;
                    if (snapshot.data.themeMode == newThemeMode) {
                      return;
                    }

                    snapshot.data.themeMode = newThemeMode;
                    bloc.save.add(snapshot.data);
                  },
                  selectedItem: themes[snapshot.data.themeMode],
                  items: themes.values.toList(),
                )
              ],
            );
          },
        ),
        child: ListView(),
      );
}
