import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/links.dart';
import 'package:coffee_break/pages/widgets/search_delegate.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class AddLinkPage extends SearchDelegate {
  AddLinkPage()
      : super(
          searchFieldLabel: 'Add link',
          textInputAction: TextInputAction.send,
        );

  final _container = Container();

  @override
  Widget buildSuggestions(BuildContext context) => _container;

  @override
  Widget buildResults(BuildContext context) {
    final link = Link.todo(uri: query);
    Provider.of<LinkBloc>(
      context,
      listen: false,
    ).save.add(link);
    Provider.of<Links>(
      context,
      listen: false,
    ).save(link);

    WidgetsBinding.instance.addPostFrameCallback((_) => close(context, query));

    query = '';

    return _container;
  }
}
