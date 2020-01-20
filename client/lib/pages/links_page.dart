import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/links.dart';
import 'package:coffee_break/pages/widgets/marked_link_tile_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoLinksPage extends StatelessWidget {
  const TodoLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: bloc.links,
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(snapshot.error.toString()),
                    )));
            }

            return child;
          },
        ),
        child: Consumer<Links>(
          builder: (_, links, __) => LinkListView(links: links.todo),
        ),
      );
}

class DoneLinksPage extends StatelessWidget {
  const DoneLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<Links>(
        builder: (_, links, __) => LinkListView(links: links.done),
      );
}

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
        itemBuilder: (context, i) => LinkListTile(link: links[i]),
      );
}

class LinkListTile extends StatelessWidget {
  const LinkListTile({
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
