import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/edit_link_page.dart';
import 'package:coffee_break/pages/widgets/fade_page_route.dart';
import 'package:coffee_break/pages/widgets/marked_link_tile_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkableLinkTile extends StatelessWidget {
  const MarkableLinkTile({
    @required Key key,
    @required this.onMarked,
    @required this.link,
  })  : assert(key != null),
        assert(onMarked != null),
        assert(link != null),
        super(key: key);

  final VoidCallback onMarked;
  final Link link;

  @override
  Widget build(BuildContext context) => Dismissible(
        key: key,
        onDismissed: (_) {
          link.isDone = !link.isDone;
          Provider.of<LinkBloc>(
            context,
            listen: false,
          ).save.add(link);

          onMarked();
        },
        background: MarkedLinkTileBackground(
          link: link,
        ),
        secondaryBackground: MarkedLinkTileBackground(
          direction: AxisDirection.left,
          link: link,
        ),
        child: LinkTile(
          link: link,
        ),
      );
}

class LinkTile extends StatelessWidget {
  const LinkTile({
    Key key,
    @required this.link,
  })  : assert(link != null),
        super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () async => await canLaunch(link.uri) ? launch(link.uri) : null,
        title: Text(link.title),
        subtitle: Row(
          children: [
            _buildVerb(context),
            const SizedBox(width: 5),
            _buildDueDate(context),
          ],
        ),
        trailing: PopupMenuButton<LinkTileActions>(
          onSelected: (action) {
            switch (action) {
              case LinkTileActions.delete:
                Provider.of<LinkBloc>(
                  context,
                  listen: false,
                ).delete.add(link);
                break;
              case LinkTileActions.edit:
                Navigator.push(
                  context,
                  FadePageRoute<EditLinkPage>(
                    builder: (_, animation, __) => EditLinkPage(
                      animation: animation,
                      link: link,
                    ),
                  ),
                );
                break;
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: LinkTileActions.delete,
              child: Text('Delete'),
            ),
            const PopupMenuItem(
              value: LinkTileActions.edit,
              child: Text('Edit'),
            ),
          ],
        ),
      );

  Widget _buildVerb(BuildContext context) =>
      link.isDone ? Text(link.verb.pastParticle) : Text(link.verb.infinitive);

  Widget _buildDueDate(BuildContext context) {
    if (link.dueDate == null || link.isDone) {
      return Container();
    }

    return Text('due ${toDueDateString(link.dueDate)}');
  }
}

enum LinkTileActions { delete, edit }
