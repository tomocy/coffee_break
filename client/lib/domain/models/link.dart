import 'package:coffee_break/domain/models/verb.dart';

String toDueDateString(DateTime dueDate) =>
    '${dueDate.year}/${dueDate.month}/${dueDate.day}';

class Link {
  Link({
    this.uri,
    this.verb = const Verb('do', 'done'),
    DateTime createdAt,
    this.dueDate,
    bool done,
  })  : createdAt = createdAt ?? DateTime.now(),
        isDone = done;

  Link.todo({
    String uri,
    Verb verb = const Verb('do', 'done'),
    DateTime createdAt,
    DateTime dueDate,
  }) : this(
          uri: uri,
          verb: verb,
          createdAt: createdAt,
          dueDate: dueDate,
          done: false,
        );

  Link.done({
    String uri,
    Verb verb = const Verb('do', 'done'),
    DateTime createdAt,
    DateTime dueDate,
  }) : this(
          uri: uri,
          verb: verb,
          createdAt: createdAt,
          dueDate: dueDate,
          done: true,
        );

  final String uri;
  final Verb verb;
  final DateTime createdAt;
  final DateTime dueDate;
  bool isDone;

  Link copyWith({
    String uri,
    Verb verb,
    DateTime createdAt,
    DateTime dueDate,
    bool done,
  }) =>
      Link(
        uri: uri ?? this.uri,
        verb: verb ?? this.verb,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
        done: done ?? isDone,
      );

  bool get isDueToday {
    if (dueDate == null) {
      return false;
    }

    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  @override
  bool operator ==(dynamic other) =>
      other is Link &&
      other.uri == uri &&
      other.verb == verb &&
      other.dueDate == dueDate;

  @override
  int get hashCode => uri.hashCode + verb.hashCode + dueDate.hashCode;
}
