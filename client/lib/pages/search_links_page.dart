import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_tile.dart';
import 'package:coffee_break/pages/widgets/search_delegate.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class SearchLinksPage extends SearchDelegate {
  final _container = Container();

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);

  @override
  Widget buildResults(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Link>>(
          stream: bloc.searchedLinks,
          builder: (_, snapshot) {
            bloc.search.add(query);
            if (!snapshot.hasData) {
              return child;
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, i) => LinkTile(link: snapshot.data[i]),
            );
          },
        ),
        child: _container,
      );
}
