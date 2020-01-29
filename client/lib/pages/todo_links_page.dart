import 'package:coffee_break/pages/widgets/page_scaffold.dart';
import 'package:coffee_break/pages/widgets/streamed_links_list_view.dart';
import 'package:flutter/material.dart';

class TodoLinksPage extends StatelessWidget {
  const TodoLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PageScaffold(
        title: 'Todo',
        type: PageType.todo,
        body: StreamedLinksListView(
          stream: (bloc) => bloc.todoLinks,
        ),
      );
}
