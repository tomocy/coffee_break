import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/add_verb_page.dart';
import 'package:coffee_break/pages/widgets/verb_tile.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:coffee_break/pages/widgets/search_delegate.dart';
import 'package:provider/provider.dart';

class SearchVerbsPage extends SearchDelegate<Verb> {
  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);

  @override
  Widget buildResults(BuildContext context) => Consumer<VerbBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Verb>>(
          stream: bloc.searchedVerbs,
          builder: (_, snapshot) {
            bloc.search.add(query);
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return child;
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, i) => VerbTile(
                onTap: () => close(
                  context,
                  snapshot.data[i],
                ),
                verb: snapshot.data[i],
              ),
            );
          },
        ),
        child: ListView(
          children: [
            ListTile(
              onTap: () async {
                final verb = await Navigator.push<Verb>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddVerbPage(),
                  ),
                );
                if (verb == null) {
                  return;
                }

                query = verb.base;
              },
              title: const Text('Add verb'),
            ),
          ],
        ),
      );
}
