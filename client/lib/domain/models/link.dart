import 'package:coffee_break/domain/models/verb.dart';

final List<Link> initialDataOfListOfLinks = [];

class Link {
  Link({
    this.uri,
    this.verb = const Verb('do', 'done'),
    DateTime createdAt,
    bool done,
  })  : createdAt = createdAt ?? DateTime.now(),
        isDone = done;

  Link.todo({
    String uri,
    Verb verb,
    DateTime createdAt,
  }) : this(
          uri: uri,
          verb: verb,
          createdAt: createdAt,
          done: false,
        );

  Link.done({
    String uri,
    Verb verb,
    DateTime createdAt,
  }) : this(
          uri: uri,
          verb: verb,
          createdAt: createdAt,
          done: true,
        );

  final String uri;
  final Verb verb;
  final DateTime createdAt;
  bool isDone;
}
