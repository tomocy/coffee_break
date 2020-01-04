import 'package:flutter/material.dart';

const routes = <PageType, String>{
  PageType.home: '/home',
  PageType.read: '/read',
};

enum PageType { home, read }

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
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  right:
                      BorderSide(color: Theme.of(context).colorScheme.surface)),
            ),
            child: ListView(children: <Widget>[
              ListTile(
                title: const Text('Home'),
                onTap: () => type == PageType.home
                    ? Navigator.pop(context)
                    : Navigator.pushNamed(
                        context,
                        routes[PageType.home],
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
            ]),
          ),
        ),
        drawerScrimColor: Colors.black12,
        body: body,
      );
}
