import 'package:coffee_break/pages/widgets/links_page_scaffold.dart';
import 'package:coffee_break/pages/widgets/page_scaffold.dart';
import 'package:coffee_break/pages/widgets/streamed_links_list_view.dart';
import 'package:flutter/material.dart';

class DoneLinksPage extends StatelessWidget {
  const DoneLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LinksPageScaffold(
        title: 'Read',
        type: PageType.done,
        body: StreamedLinksListView(
          stream: (bloc) => bloc.doneLinks,
        ),
      );
}
