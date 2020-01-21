import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/link_list_view.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamedLinkListView extends StatelessWidget {
  const StreamedLinkListView({
    Key key,
    @required this.stream,
    this.child,
  })  : assert(stream != null),
        super(key: key);

  final Stream<List<Link>> stream;
  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Link>>(
        stream: stream,
        builder: (_, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            Provider.of<LinkBloc>(
              context,
              listen: false,
            ).notify.add(null);
            return child;
          }
          if (snapshot.hasError) {
            return child;
          }

          return LinkListView(links: snapshot.data);
        },
      );
}
