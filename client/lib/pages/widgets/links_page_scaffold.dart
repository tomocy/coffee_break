import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/pages/widgets/page_scaffold.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/stream_handler.dart';
import 'package:coffee_break/pages/widgets/undo_snack_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinksPageScaffold extends StatelessWidget {
  const LinksPageScaffold({
    Key key,
    @required this.type,
    @required this.title,
    this.body,
  }) : super(key: key);

  final PageType type;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) => PageScaffold(
        title: title,
        type: type,
        body: MultiStreamHandler(
          handlers: [
            StreamHandler<List<Link>>(
              stream: Provider.of<LinkBloc>(
                context,
                listen: false,
              ).links,
              onError: (context, error) => showSnackBar(
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
              onError: (context, error) {
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
              onData: (context, link) => showSnackBar(
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
              onError: (context, error) {
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
          ],
          child: body,
        ),
      );
}
