import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class StreamErrorHandler<T> extends SingleChildStatelessWidget {
  const StreamErrorHandler({
    Key key,
    @required this.stream,
    @required this.onError,
    Widget child,
  })  : assert(stream != null),
        assert(onError != null),
        super(
          key: key,
          child: child,
        );

  final Stream<T> stream;
  final Function(Object) onError;

  @override
  Widget buildWithChild(BuildContext context, Widget child) => StreamBuilder<T>(
        stream: stream,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            onError(snapshot.error);
          }

          return child ?? Container();
        },
      );
}
