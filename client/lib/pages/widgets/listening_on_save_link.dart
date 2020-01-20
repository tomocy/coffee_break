import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListeningOnSaveLink extends StatelessWidget {
  const ListeningOnSaveLink({
    Key key,
    this.onData,
    this.onError,
    this.onNothing,
    this.child,
  }) : super(key: key);

  final void Function(bool) onData;
  final void Function(LinkRepositorySaveException) onError;
  final void Function() onNothing;
  final Widget child;

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<bool>(
          stream: bloc.saved,
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              if (onNothing != null) {
                onNothing();
              }

              return child;
            }

            if (snapshot.hasError &&
                snapshot.error is LinkRepositorySaveException) {
              final error = snapshot.error as LinkRepositorySaveException;
              showSnackBar(
                context,
                SnackBar(
                  action: SnackBarAction(
                    onPressed: () => bloc.save.add(error.link),
                    label: 'RETRY',
                  ),
                  content: Text(snapshot.error.toString()),
                ),
              );

              if (onError != null) {
                onError(error);
              }

              return child;
            }

            if (onData != null) {
              onData(snapshot.data);
            }

            return child;
          },
        ),
        child: child ?? Container(),
      );
}
