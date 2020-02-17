String toDueDateString(DateTime dueDate) =>
    '${dueDate.year}/${dueDate.month}/${dueDate.day}';

class Link {
  Link({
    this.uri,
    this.title,
    DateTime createdAt,
    this.dueDate,
    bool done,
  })  : createdAt = createdAt ?? DateTime.now(),
        isDone = done;

  Link.todo({
    String uri,
    String title,
    DateTime createdAt,
    DateTime dueDate,
  }) : this(
          uri: uri,
          title: title,
          createdAt: createdAt,
          dueDate: dueDate,
          done: false,
        );

  Link.done({
    String uri,
    String title,
    DateTime createdAt,
    DateTime dueDate,
  }) : this(
          uri: uri,
          title: title,
          createdAt: createdAt,
          dueDate: dueDate,
          done: true,
        );

  final String uri;
  final String title;
  final DateTime createdAt;
  final DateTime dueDate;
  bool isDone;

  Link copyWith({
    String uri,
    String title,
    DateTime createdAt,
    DateTime dueDate,
    bool done,
  }) =>
      Link(
        uri: uri ?? this.uri,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
        done: done ?? isDone,
      );

  bool get isToday => isDueToday && !isDone;

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
      other is Link && other.uri == uri && other.dueDate == dueDate;

  @override
  int get hashCode => uri.hashCode + dueDate.hashCode;
}
