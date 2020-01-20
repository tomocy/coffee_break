import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
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
                SettingListTile(
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

class SettingListTile extends StatefulWidget {
  const SettingListTile({
    Key key,
    this.title,
    this.onChanged,
    this.selectedItem,
    this.items,
  }) : super(key: key);

  final String title;
  final void Function(String) onChanged;
  final String selectedItem;
  final List<String> items;

  @override
  _SettingListTileState createState() => _SettingListTileState();
}

class _SettingListTileState extends State<SettingListTile> {
  String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(widget.title),
        trailing: DropdownButton<String>(
          elevation: 1,
          value: _selectedItem,
          onChanged: (item) {
            setState(() => _selectedItem = item);
            widget.onChanged(item);
          },
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
        ),
      );
}
