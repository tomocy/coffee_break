import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/marked_link_tile_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

ListView buildLinkListView([List<Link> links = const []]) => ListView.builder(
      itemCount: links.length,
      itemBuilder: (_, i) => LinkTile(link: links[i]),
    );

class LinkTile extends StatelessWidget {
  const LinkTile({
    Key key,
    @required this.link,
  })  : assert(link != null),
        super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          link.isDone = !link.isDone;
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
          onTap: () async =>
              await canLaunch(link.uri) ? launch(link.uri) : null,
          title: Text(link.uri),
          subtitle: link.isDone
              ? Text(link.verb.pastParticle)
              : Text(link.verb.infinitive),
          trailing: PopupMenuButton<LinkTileActions>(
            onSelected: (action) {
              switch (action) {
                case LinkTileActions.delete:
                  Provider.of<LinkBloc>(
                    context,
                    listen: false,
                  ).delete.add(link);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: LinkTileActions.delete,
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      );
}

enum LinkTileActions { delete }
