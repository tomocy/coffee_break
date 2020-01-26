import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/pages/add_link_page.dart';
import 'package:coffee_break/pages/search_links_page.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/stream_handler.dart';
import 'package:coffee_break/pages/widgets/undo_snack_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const routes = <PageType, String>{
  PageType.today: '/today',
  PageType.todo: '/todo',
  PageType.done: '/done',
  PageType.settings: '/settings',
};

enum PageType { today, todo, done, settings }

class Page extends StatelessWidget {
  const Page({
    Key key,
    @required this.type,
    @required this.title,
    this.body,
  })  : assert(type != null),
        assert(title != null),
        super(key: key);

  final PageType type;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: Drawer(
          elevation: 1,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Todo'),
                        onTap: () {
                          Navigator.pop(context);

                          if (type == PageType.todo) {
                            return;
                          }

                          Navigator.pushNamed(
                            context,
                            routes[PageType.todo],
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Done'),
                        onTap: () {
                          Navigator.pop(context);

                          if (type == PageType.done) {
                            return;
                          }

                          Navigator.pushNamed(
                            context,
                            routes[PageType.done],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Add'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute<AddLinkPage>(
                        builder: (_) => const AddLinkPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Search'),
                  onTap: () {
                    Navigator.pop(context);
                    showSearch(
                      context: context,
                      delegate: SearchLinksPage(),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);

                    if (type == PageType.settings) {
                      return;
                    }

                    Navigator.pushNamed(
                      context,
                      routes[PageType.settings],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        drawerScrimColor: Colors.transparent,
        body: _buildStreamHandlers(
          context,
          SafeArea(child: body),
        ),
      );

  Widget _buildStreamHandlers(BuildContext context, Widget child) =>
      MultiStreamHandler(
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
        child: child,
      );
}

void showSnackBar(BuildContext context, SnackBar snackbar) =>
    WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar));
