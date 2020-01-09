import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkListView extends StatelessWidget {
  const LinkListView({
    Key key,
    @required this.links,
  })  : assert(links != null),
        super(key: key);

  final List<Link> links;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: links.length,
        itemBuilder: (context, i) => LinkListTile(link: links[i]),
      );
}

class LinkListTile extends StatelessWidget {
  const LinkListTile({
    Key key,
    @required this.link,
  })  : assert(link != null),
        super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(link.uri),
        trailing: MarkAsReadButton(link: link),
      );
}

class MarkAsReadButton extends StatelessWidget {
  const MarkAsReadButton({
    Key key,
    @required this.link,
  })  : assert(link != null),
        super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => link.read
      ? FlatButton(
          onPressed: () =>
              Provider.of<Links>(context, listen: false).markAsUnread(link),
          child: const Text('Unread'),
        )
      : FlatButton(
          onPressed: () =>
              Provider.of<Links>(context, listen: false).markAsRead(link),
          child: const Text('Read'),
        );
}

class Links extends ChangeNotifier {
  final List<Link> _links = [];

  List<Link> get all => _links;
  List<Link> get unread => _links.where((link) => !link.read).toList();
  List<Link> get read => _links.where((link) => link.read).toList();

  void markAsRead(Link link) => _markAsRead(link, true);

  void markAsUnread(Link link) => _markAsRead(link, false);

  void _markAsRead(Link link, bool read) {
    final i = all.indexOf(link);
    if (i < 0 || all[i].read == read) {
      return;
    }

    all[i].read = read;
    notifyListeners();
  }
}

class Link {
  Link({
    @required this.uri,
    this.read = false,
  }) : assert(uri != null);

  final String uri;
  bool read;
}
