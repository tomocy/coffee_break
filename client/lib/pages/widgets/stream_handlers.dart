import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/stream_handler.dart';
import 'package:coffee_break/pages/widgets/undo_snack_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class StreamHandlers extends StatelessWidget {
  const StreamHandlers({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiStreamHandler(
        handlers: [
          StreamHandler<List<Link>>(
            stream: Provider.of<LinkBloc>(
              context,
              listen: false,
            ).links,
            onError: (error) => showSnackBar(
              context,
              SnackBar(
                action: RetrySnackBarAction(
                  onPressed: () => Provider.of<LinkBloc>(
                    context,
                    listen: false,
                  ).fetch.add(null),
                ),
                content: Text(error.toString()),
              ),
            ),
          ),
          StreamHandler<void>(
            stream: Provider.of<LinkBloc>(
              context,
              listen: false,
            ).saved,
            onError: (error) {
              if (error is! LinkRepositorySaveException) {
                return;
              }

              final saveError = error as LinkRepositorySaveException;
              showSnackBar(
                context,
                SnackBar(
                  action: RetrySnackBarAction(
                    onPressed: () => Provider.of<LinkBloc>(
                      context,
                      listen: false,
                    ).save.add(saveError.link),
                  ),
                  content: Text(error.toString()),
                ),
              );
            },
          ),
          StreamHandler<Link>(
            stream: Provider.of<LinkBloc>(
              context,
              listen: false,
            ).deleted,
            onData: (link) => showSnackBar(
              context,
              SnackBar(
                action: UndoSnackBarAction(
                  onPressed: () => Provider.of<LinkBloc>(
                    context,
                    listen: false,
                  ).save.add(link),
                ),
                content: const Text('Link was deleted.'),
              ),
            ),
            onError: (error) {
              if (error is! LinkRepositoryDeleteException) {
                return;
              }

              final deleteError = error as LinkRepositoryDeleteException;
              showSnackBar(
                context,
                SnackBar(
                  action: RetrySnackBarAction(
                    onPressed: () => Provider.of<LinkBloc>(
                      context,
                      listen: false,
                    ).delete.add(deleteError.link),
                  ),
                  content: Text(error.toString()),
                ),
              );
            },
          ),
          StreamHandler<List<Verb>>(
            stream: Provider.of<VerbBloc>(
              context,
              listen: false,
            ).verbs,
            onError: (error) {
              if (error is! VerbRepositoryFetchException) {
                return;
              }

              showSnackBar(
                context,
                SnackBar(
                  action: RetrySnackBarAction(
                    onPressed: () => Provider.of<VerbBloc>(
                      context,
                      listen: false,
                    ).fetch.add(null),
                  ),
                  content: Text(error.toString()),
                ),
              );
            },
          ),
        ],
        child: child,
      );
}

class MultiStreamHandler extends Nested {
  MultiStreamHandler({
    Key key,
    @required List<SingleChildWidget> handlers,
    @required Widget child,
  })  : assert(handlers != null),
        assert(child != null),
        super(
          key: key,
          children: handlers,
          child: child,
        );
}
