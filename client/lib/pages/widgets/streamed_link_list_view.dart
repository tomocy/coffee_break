import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamedLinkListView extends StatelessWidget {
  const StreamedLinkListView({
    Key key,
    @required this.stream,
    this.onNothing,
    this.child,
  })  : assert(stream != null),
        super(key: key);

  final Stream<List<Link>> stream;
  final Function onNothing;
  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Link>>(
        stream: stream,
        builder: (_, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            if (onNothing != null) {
              onNothing();
            }
            return child;
          }
          if (snapshot.hasError) {
            return child;
          }

          return LinkListView(links: snapshot.data);
        },
      );
}
