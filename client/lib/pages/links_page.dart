import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_tile.dart';
import 'package:coffee_break/pages/widgets/refreshable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoLinksPage extends StatelessWidget {
  const TodoLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: bloc.todoLinks,
          builder: (_, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              bloc.notify.add(null);
              return child;
            }
            if (snapshot.hasError) {
              return child;
            }

            return _buildFetchableLinkListView(context, snapshot.data);
          },
        ),
        child: _buildFetchableLinkListView(context),
      );
}

class DoneLinksPage extends StatelessWidget {
  const DoneLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: bloc.doneLinks,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              bloc.notify.add(null);
              return child;
            }

            return _buildFetchableLinkListView(context, snapshot.data);
          },
        ),
        child: _buildFetchableLinkListView(context),
      );
}

Widget _buildFetchableLinkListView(BuildContext context,
        [List<Link> links = const []]) =>
    Refreshable(
      onRefresh: () async => Provider.of<LinkBloc>(
        context,
        listen: false,
      ).fetch.add(null),
      child: buildLinkListView(links),
    );
