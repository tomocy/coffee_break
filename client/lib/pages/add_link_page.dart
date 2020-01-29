import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';
import 'package:coffee_break/pages/widgets/link_form.dart';
import 'package:coffee_break/pages/widgets/page_scaffold.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/stream_handler.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class AddLinkPageRoute extends PageRoute<AddLinkPage> {
  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return AddLinkPage(
      animation: animation,
    );
  }
}

class AddLinkPage extends StatelessWidget {
  const AddLinkPage({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: AnimatedIcon(
                    progress: animation,
                    icon: AnimatedIcons.menu_arrow,
                  ),
                )
              : null,
          title: const Text('Add link'),
        ),
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
            onError: (context, error) {
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
          StreamHandler<bool>(
            stream: Provider.of<VerbBloc>(
              context,
              listen: false,
            ).saved,
            onError: (context, error) {
              if (error is! VerbRepositorySaveException) {
                return;
              }

              final saveError = error as VerbRepositorySaveException;
              showSnackBar(
                context,
                SnackBar(
                  action: RetrySnackBarAction(
                    onPressed: () => Provider.of<VerbBloc>(
                      context,
                      listen: false,
                    ).save.add(saveError.verb),
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
