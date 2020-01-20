import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_tile.dart';
import 'package:flutter/material.dart';

class LinkListView extends StatelessWidget {
  const LinkListView({
    Key key,
    @required this.links,
  })  : assert(links != null),
        super(key: key);

  final List<Link> links;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: links.length,
        itemBuilder: (context, i) => LinkTile(link: links[i]),
      );
}
