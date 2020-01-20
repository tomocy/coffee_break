final List<Link> initialDataOfListOfLinks = [];

class Link {
  Link({
    this.uri,
    bool done,
  }) : isDone = done;

  Link.todo({
    String uri,
  }) : this(
          uri: uri,
          done: false,
        );

  final String uri;
  bool isDone;
}
