import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_list_view.dart';
import 'package:coffee_break/pages/widgets/link_tile.dart';
import 'package:coffee_break/pages/widgets/search_delegate.dart';
import 'package:coffee_break/pages/widgets/streamed_link_list_view.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class SearchLinksPage extends SearchDelegate {
  final _container = Container();

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);

  @override
  Widget buildResults(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamedLinkListView(
          stream: bloc.searchedLinks,
          onSnapshot: (_) => bloc.search.add(query),
          child: child,
        ),
        child: const LinkListView(),
      );
}
