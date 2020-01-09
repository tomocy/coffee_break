import 'package:flutter/material.dart';

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
