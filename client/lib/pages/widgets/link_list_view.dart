import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_tile.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class LinkListView extends StatelessWidget {
  const LinkListView({
    Key key,
    @required this.links,
  })  : assert(links != null),
        super(key: key);

  final List<Link> links;

  @override
  Widget build(BuildContext context) => LiquidPullToRefresh(
        onRefresh: () async => Provider.of<LinkBloc>(
          context,
          listen: false,
        ).fetch.add(null),
        child: ListView.builder(
          itemCount: links.length,
          itemBuilder: (context, i) => LinkTile(link: links[i]),
        ),
      );
}
