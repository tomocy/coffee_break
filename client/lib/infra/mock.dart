class Mock {
  const Mock({this.failer});

  final Failer failer;

  bool get doFail {
    if (failer != null) {
      return failer();
    }

    return false;
  }
}

typedef Failer = bool Function();
