import 'package:coffee_break/pages/add_link_page.dart';
import 'package:coffee_break/pages/search_links_page.dart';
import 'package:flutter/material.dart';

const routes = <PageType, String>{
  PageType.today: '/today',
  PageType.todo: '/todo',
  PageType.done: '/done',
  PageType.settings: '/settings',
};

enum PageType { today, todo, done, settings }

class PageScaffold extends StatelessWidget {
  const PageScaffold({
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
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text('Today'),
                        onTap: () {
                          Navigator.pop(context);

                          if (type == PageType.today) {
                            return;
                          }

                          Navigator.pushReplacementNamed(
                            context,
                            routes[PageType.today],
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Todo'),
                        onTap: () {
                          Navigator.pop(context);

                          if (type == PageType.todo) {
                            return;
                          }

                          Navigator.pushReplacementNamed(
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

                          Navigator.pushReplacementNamed(
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
                      AddLinkPageRoute(),
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

                    Navigator.pushReplacementNamed(
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
        body: SafeArea(child: body),
      );
}

void showSnackBar(BuildContext context, SnackBar snackbar) =>
    WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar));
