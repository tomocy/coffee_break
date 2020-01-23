import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/streamed_links_list_view.dart';
import 'package:flutter/material.dart';

class DoneLinksPage extends StatelessWidget {
  const DoneLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Page(
        title: 'Done',
        type: PageType.done,
        body: StreamedLinksListView(
          stream: (bloc) => bloc.doneLinks,
        ),
      );
}
