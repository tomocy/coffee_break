import 'package:coffee_break/domain/models/link.dart';
import 'package:flutter/material.dart';

class Links extends ChangeNotifier {
  Links(this._links);

  final List<Link> _links;

  List<Link> get all => _links;
  List<Link> get todo => _links.where((link) => !link.isDone).toList();
  List<Link> get done => _links.where((link) => link.isDone).toList();

  void save(Link link) {
    final i = _links.indexOf(link);
    if (i < 0) {
      _links.add(link);
      return;
    }

    _links[i] = link;
  }

  void markAsDone(Link link) => _markAsDone(
        link,
        true,
      );

  void markAsUndone(Link link) => _markAsDone(
        link,
        false,
      );

  void _markAsDone(Link link, bool isDone) {
    final i = all.indexOf(link);
    if (i < 0 || all[i].isDone == isDone) {
      return;
    }

    all[i].isDone = isDone;
    notifyListeners();
  }
}
