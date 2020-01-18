import 'package:flutter/material.dart';

const routes = <PageType, String>{
  PageType.unread: '/unread',
  PageType.read: '/read',
  PageType.settings: '/settings',
};

enum PageType { unread, read, settings }

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
                        title: const Text('Unread'),
                        onTap: () => type == PageType.unread
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(
                                context,
                                routes[PageType.unread],
                              ),
                      ),
                      ListTile(
                        title: const Text('Read'),
                        onTap: () => type == PageType.read
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(
                                context,
                                routes[PageType.read],
                              ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () => type == PageType.settings
                      ? Navigator.pop(context)
                      : Navigator.pushNamed(
                          context,
                          routes[PageType.settings],
                        ),
                )
              ],
            ),
          ),
        ),
        drawerScrimColor: Colors.transparent,
        body: SafeArea(child: body),
      );
}
