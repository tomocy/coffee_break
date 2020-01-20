final List<Link> initialDataOfListOfLinks = [];

class Link {
  Link({
    this.uri,
    DateTime createdAt,
    bool done,
  })  : createdAt = createdAt ?? DateTime.now(),
        isDone = done;

  Link.todo({
    String uri,
    DateTime createdAt,
  }) : this(
          uri: uri,
          createdAt: createdAt,
          done: false,
        );

  Link.done({
    String uri,
    DateTime createdAt,
  }) : this(
          uri: uri,
          createdAt: createdAt,
          done: true,
        );

  final String uri;
  final DateTime createdAt;
  bool isDone;
}
