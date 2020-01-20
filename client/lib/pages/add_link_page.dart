import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/search_delegate.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class AddLinkPage extends SearchDelegate {
  AddLinkPage()
      : super(
          searchFieldLabel: 'Add',
          textInputAction: TextInputAction.send,
        );

  final _container = Container();

  @override
  Widget buildSuggestions(BuildContext context) => _container;

  @override
  Widget buildResults(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamBuilder<bool>(
            stream: bloc.saved,
            builder: (context, snapshot) {
              if (query.isEmpty) {
                return child;
              }

              final link = Link.todo(uri: query);
              if (!snapshot.hasData && !snapshot.hasError) {
                bloc.save.add(link);
                return child;
              }

              if (snapshot.hasError) {
                showSnackBar(
                  context,
                  SnackBar(
                    action: SnackBarAction(
                      onPressed: () => bloc.save.add(link),
                      label: 'RETRY',
                    ),
                    content: Text(snapshot.error.toString()),
                  ),
                );
                return child;
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                close(context, query);
                query = '';
              });

              return child;
            }),
        child: _container,
      );
}
