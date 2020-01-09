import 'package:flutter/material.dart';

const routes = <PageType, String>{
  PageType.home: '/home',
  PageType.settings: '/settings',
};

enum PageType { home, settings }

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
                        title: const Text('Home'),
                        onTap: () => type == PageType.home
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(
                                context,
                                routes[PageType.home],
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
        body: body,
      );
}
