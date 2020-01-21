import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

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
  final Function(T) onData;
  final Function(Object) onError;

  @override
  Widget buildWithChild(BuildContext context, Widget child) => StreamBuilder<T>(
        stream: stream,
        builder: (_, snapshot) {
          if (snapshot.hasData && onData != null) {
            onData(snapshot.data);
          }
          if (snapshot.hasError && onError != null) {
            onError(snapshot.error);
          }

          return child ?? Container();
        },
      );
}
