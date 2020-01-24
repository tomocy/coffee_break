import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/edit_verb_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerbTile extends StatelessWidget {
  const VerbTile({
    Key key,
    this.onTap,
    @required this.verb,
  })  : assert(verb != null),
        super(key: key);

  final VoidCallback onTap;
  final Verb verb;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        title: Text(verb.base),
        trailing: PopupMenuButton<VerbTileActions>(
          onSelected: (action) {
            switch (action) {
              case VerbTileActions.delete:
                Provider.of<VerbBloc>(
                  context,
                  listen: false,
                ).delete.add(verb);
                break;
              case VerbTileActions.edit:
                Navigator.push(
                  context,
                  MaterialPageRoute<EditVerbPage>(
                    builder: (_) => EditVerbPage(verb: verb),
                  ),
                );
                break;
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: VerbTileActions.delete,
              child: Text('Delete'),
            ),
            const PopupMenuItem(
              value: VerbTileActions.edit,
              child: Text('Edit'),
            ),
          ],
        ),
      );
}

enum VerbTileActions { delete, edit }
