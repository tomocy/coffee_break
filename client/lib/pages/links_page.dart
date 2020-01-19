import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/links.dart';
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
  Widget build(BuildContext context) => ListTile(
        title: Text(link.uri),
        trailing: MarkAsDoneButton(link: link),
      );
}

class MarkAsDoneButton extends StatelessWidget {
  const MarkAsDoneButton({
    Key key,
    @required this.link,
  })  : assert(link != null),
        super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => link.isDone
      ? FlatButton(
          onPressed: () => Provider.of<Links>(
            context,
            listen: false,
          ).markAsUndone(link),
          child: const Text('Undo'),
        )
      : FlatButton(
          onPressed: () => Provider.of<Links>(
            context,
            listen: false,
          ).markAsDone(link),
          child: const Text('Done'),
        );
}
