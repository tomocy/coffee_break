import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/add_link_page.dart';
import 'package:coffee_break/pages/search_links_page.dart';
import 'package:coffee_break/pages/widgets/stream_handlers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const routes = <PageType, String>{
  PageType.todo: '/todo',
  PageType.done: '/done',
  PageType.settings: '/settings',
};

enum PageType { todo, done, settings }

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
        body: StreamHandlers(child: SafeArea(child: body)),
      );
}

void showSnackBar(BuildContext context, SnackBar snackbar) =>
    WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar));
