import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/pages/widgets/streamed_link_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoLinksPage extends StatelessWidget {
  const TodoLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamedLinkListView(
          stream: bloc.todoLinks,
          child: child,
        ),
        child: Container(),
      );
}

class DoneLinksPage extends StatelessWidget {
  const DoneLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LinkBloc>(
        builder: (_, bloc, child) => StreamedLinkListView(
          stream: bloc.doneLinks,
          child: child,
        ),
        child: Container(),
      );
}
