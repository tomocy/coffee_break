import 'package:flutter/material.dart';

class Link {
  Link({
    @required this.uri,
    this.read = false,
  }) : assert(uri != null);

  final String uri;
  bool read;
}
