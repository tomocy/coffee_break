import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/undo_snack_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListeningOnDeleteLink extends StatelessWidget {
  const ListeningOnDeleteLink({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<Link>(
          stream: bloc.deleted,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              showSnackBar(
                context,
                SnackBar(
                  action: UndoSnackBarAction(
                    onPressed: () => bloc.save.add(snapshot.data),
                  ),
                  content: const Text('Link was deleted.'),
                ),
              );
            } else if (snapshot.hasError &&
                snapshot.error is LinkRepositoryDeleteException) {
              final error = snapshot.error as LinkRepositoryDeleteException;
              showSnackBar(
                context,
                SnackBar(
                  action: RetrySnackBarAction(
                    onPressed: () => bloc.delete.add(error.link),
                  ),
                  content: Text(error.toString()),
                ),
              );
            }

            return child;
          },
        ),
        child: child ?? Container(),
      );
}
