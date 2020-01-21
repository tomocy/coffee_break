import 'package:coffee_break/pages/add_link_page.dart';
import 'package:coffee_break/pages/search_links_page.dart';
import 'package:coffee_break/pages/widgets/stream_error_handlers.dart';
import 'package:flutter/material.dart';

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
                        onTap: () => type == PageType.todo
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(
                                context,
                                routes[PageType.todo],
                              ),
                      ),
                      ListTile(
                        title: const Text('Done'),
                        onTap: () => type == PageType.done
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(
                                context,
                                routes[PageType.done],
                              ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Add'),
                  onTap: () {
                    Navigator.pop(context);
                    showSearch(
                      context: context,
                      delegate: AddLinkPage(),
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
                  onTap: () => type == PageType.settings
                      ? Navigator.pop(context)
                      : Navigator.pushNamed(
                          context,
                          routes[PageType.settings],
                        ),
                ),
              ],
            ),
          ),
        ),
        drawerScrimColor: Colors.transparent,
        body: StreamErrorHandlers(child: SafeArea(child: body)),
      );
}

void showSnackBar(BuildContext context, SnackBar snackbar) =>
    WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar));
