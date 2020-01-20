import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/links.dart';
import 'package:coffee_break/pages/widgets/marked_link_tile_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkTile extends StatelessWidget {
  const LinkTile({
    Key key,
    @required this.link,
  })  : assert(link != null),
        super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => Dismissible(
        key: Key(link.uri),
        onDismissed: (_) {
          link.isDone = !link.isDone;
          Provider.of<Links>(
            context,
            listen: false,
          ).save(link);
          Provider.of<LinkBloc>(
            context,
            listen: false,
          ).save.add(link);
        },
        background: MarkedLinkTileBackground(link: link),
        secondaryBackground: MarkedLinkTileBackground(
          direction: AxisDirection.left,
          link: link,
        ),
        child: ListTile(
          title: Text(link.uri),
        ),
      );
}
