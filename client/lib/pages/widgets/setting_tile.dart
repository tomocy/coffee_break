import 'package:flutter/material.dart';

class SettingTile extends StatefulWidget {
  const SettingTile({
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
  _SettingTileState createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
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
