import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoLinksPage extends StatelessWidget {
  const TodoLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: bloc.todoLinks,
          builder: (_, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return child;
            }

            return LinkListView(links: snapshot.data);
          },
        ),
        child: const LinkListView(),
      );
}

class DoneLinksPage extends StatelessWidget {
  const DoneLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: bloc.doneLinks,
          builder: (_, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return child;
            }

            return LinkListView(links: snapshot.data);
          },
        ),
        child: const LinkListView(),
      );
}
