import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class MultiStreamHandler extends Nested {
  MultiStreamHandler({
    Key key,
    @required List<StreamHandler> handlers,
    @required Widget child,
  })  : assert(handlers != null),
        assert(child != null),
        super(
          key: key,
          children: handlers,
          child: child,
        );
}

class StreamHandler<T> extends SingleChildStatelessWidget {
  const StreamHandler({
    Key key,
    @required this.stream,
    this.onData,
    this.onError,
    Widget child,
  })  : assert(stream != null),
        super(
          key: key,
          child: child,
        );

  final Stream<T> stream;
  final Function(BuildContext, T) onData;
  final Function(BuildContext, Object) onError;

  @override
  Widget buildWithChild(BuildContext context, Widget child) => StreamBuilder<T>(
        stream: stream,
        builder: (_, snapshot) {
          if (snapshot.hasData && onData != null) {
            onData(context, snapshot.data);
          }
          if (snapshot.hasError && onError != null) {
            onError(context, snapshot.error);
          }

          return child ?? Container();
        },
      );
}
