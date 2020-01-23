import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/link_form.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/stream_handler.dart';
import 'package:coffee_break/pages/widgets/stream_handlers.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class AddLinkPage extends StatelessWidget {
  const AddLinkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Add link')),
        body: _buildStreamHandlers(
          context,
          SafeArea(
            child: LinkForm(
              onSubmit: (link) {
                Provider.of<LinkBloc>(
                  context,
                  listen: false,
                ).save.add(link);

                Navigator.pop(context);
              },
              submitButtonLabel: 'Add',
            ),
          ),
        ),
      );

  Widget _buildStreamHandlers(BuildContext context, Widget child) =>
      MultiStreamHandler(
        handlers: [
          StreamHandler<List<Verb>>(
            stream: Provider.of<VerbBloc>(
              context,
              listen: false,
            ).verbs,
            onError: (_, error) {
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
