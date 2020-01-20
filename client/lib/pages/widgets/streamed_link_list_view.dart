import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/link_list_view.dart';
import 'package:flutter/material.dart';

class StreamedLinkListView extends StatelessWidget {
  const StreamedLinkListView({
    Key key,
    @required this.bloc,
    @required this.stream,
    this.child,
  })  : assert(bloc != null),
        assert(stream != null),
        super(key: key);

  final LinkBloc bloc;
  final Stream<List<Link>> stream;
  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Link>>(
        stream: stream,
        builder: (_, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            bloc.notify.add(null);
            return child;
          }

          if (snapshot.hasError) {
            showSnackBar(
              context,
              SnackBar(
                action: SnackBarAction(
                  onPressed: () => bloc.fetch.add(null),
                  label: 'RETRY',
                ),
                content: Text(snapshot.error.toString()),
              ),
            );
            return child;
          }

          return LinkListView(links: snapshot.data);
        },
      );
}
