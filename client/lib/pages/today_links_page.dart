import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/streamed_links_list_view.dart';
import 'package:flutter/material.dart';

class TodayLinksPage extends StatelessWidget {
  const TodayLinksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Page(
        type: PageType.today,
        title: 'Today',
        body: StreamedLinksListView(
          stream: (bloc) => bloc.todayLinks,
        ),
      );
}
