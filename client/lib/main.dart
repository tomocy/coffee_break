import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Page(
          title: 'Home',
          fetch: () async {
            return Future.delayed(
              const Duration(seconds: 1),
              () => List.generate(100, (i) => 'List $i'),
            );
          },
        ),
      );
}

class Page extends StatefulWidget {
  const Page({
    Key key,
    @required this.title,
    @required this.fetch,
  })  : assert(title != null),
        assert(fetch != null),
        super(key: key);

  final String title;
  final Future<List<String>> Function() fetch;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  Future<List<String>> _links;

  @override
  void initState() {
    super.initState();
    _links = widget.fetch();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: FutureBuilder<List<String>>(
          future: _links,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) =>
                    ListTile(title: Text(snapshot.data[i])),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      );
}
