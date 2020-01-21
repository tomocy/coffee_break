import 'package:flutter/material.dart';

class StreamErrorHandler<T> extends StatelessWidget {
  const StreamErrorHandler({
    Key key,
    @required this.stream,
    @required this.onError,
    @required this.child,
  })  : assert(stream != null),
        assert(onError != null),
        assert(child != null),
        super(key: key);

  final Stream<T> stream;
  final Function(Object) onError;
  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: stream,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            onError(snapshot.error);
          }

          return child;
        },
      );
}
