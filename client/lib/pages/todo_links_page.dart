import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/streamed_links_list_view.dart';
import 'package:flutter/material.dart';

class TodoLinksPage extends StatelessWidget {
  const TodoLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Page(
        title: 'Todo',
        type: PageType.todo,
        body: StreamedLinksListView(
          stream: (bloc) => bloc.todoLinks,
        ),
      );
}
