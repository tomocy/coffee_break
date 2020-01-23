import 'package:coffee_break/domain/models/verb.dart';

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
    Verb verb = const Verb('do', 'done'),
    DateTime createdAt,
  }) : this(
          uri: uri,
          verb: verb,
          createdAt: createdAt,
          done: false,
        );

  Link.done({
    String uri,
    Verb verb = const Verb('do', 'done'),
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

  Link copyWith({
    String uri,
    Verb verb,
    DateTime createdAt,
    bool done,
  }) =>
      Link(
        uri: uri ?? this.uri,
        verb: verb ?? this.verb,
        createdAt: createdAt ?? this.createdAt,
        done: done ?? isDone,
      );

  @override
  bool operator ==(dynamic other) =>
      other is Link && other.uri == uri && other.verb == verb;

  @override
  int get hashCode => uri.hashCode + verb.hashCode;
}
