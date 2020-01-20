import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/links.dart';
import 'package:coffee_break/pages/widgets/link_list_view.dart';
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
          builder: (_, links, __) => LinkListView(links: links.done),
        ),
      );
}
