import 'package:coffee_break/blocs/settings_bloc.dart';
import 'package:coffee_break/domain/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<Settings>(
        builder: (_, settings, __) => ListView(
          children: <Widget>[
            SettingListTile(
              title: 'Theme',
              onChanged: (theme) {
                final newThemeMode = themes.entries
                    .firstWhere((entry) => entry.value == theme)
                    .key;
                if (settings.themeMode == newThemeMode) {
                  return;
                }

                settings.themeMode = newThemeMode;
                Provider.of<SettingsBloc>(
                  context,
                  listen: false,
                ).save.add(settings);
              },
              selectedItem: themes[settings.themeMode],
              items: themes.values.toList(),
            )
          ],
        ),
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
