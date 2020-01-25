import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_tile.dart';
import 'package:coffee_break/pages/widgets/refreshable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamedLinksListView extends StatelessWidget {
  const StreamedLinksListView({
    Key key,
    this.linkKeyPrefix,
    @required this.stream,
  })  : assert(stream != null),
        super(key: key);

  final String linkKeyPrefix;
  final Stream<List<Link>> Function(LinkBloc) stream;

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: stream(bloc),
          builder: (_, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              bloc.notify.add(null);
              return child;
            }
            if (snapshot.hasError) {
              return child;
            }

            return _buildFetchableLinkListView(
              context,
              linkKeyPrefix: linkKeyPrefix,
              links: snapshot.data,
            );
          },
        ),
        child: _buildFetchableLinkListView(context),
      );

  Widget _buildFetchableLinkListView(
    BuildContext context, {
    String linkKeyPrefix,
    List<Link> links = const [],
  }) =>
      Refreshable(
        onRefresh: () async => Provider.of<LinkBloc>(
          context,
          listen: false,
        ).fetch.add(null),
        child: buildLinkListView(
          links: links,
        ),
      );
}
