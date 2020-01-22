import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/search_delegate.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class AddLinkPage extends StatefulWidget {
  const AddLinkPage({Key key}) : super(key: key);

  @override
  _AddLinkPageState createState() => _AddLinkPageState();
}

class _AddLinkPageState extends State<AddLinkPage> {
  final _formKey = GlobalKey<FormState>();
  final _linkController = TextEditingController();

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _linkController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'link',
                    ),
                    validator: (link) =>
                        link.isEmpty ? 'Please enter link.' : null,
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: double.infinity,
                    ),
                    child: RaisedButton.icon(
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        final link = Link.todo(uri: _linkController.text);
                        Provider.of<LinkBloc>(
                          context,
                          listen: false,
                        ).save.add(link);

                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.link),
                      label: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
