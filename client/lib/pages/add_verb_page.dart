import 'package:coffee_break/pages/widgets/verb_form.dart';
import 'package:flutter/material.dart';

class AddVerbPage extends StatelessWidget {
  const AddVerbPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add verb'),
        ),
        body: SafeArea(
          child: VerbForm(
            onSubmit: (verb) {},
            submitButtonLabel: 'Add',
          ),
        ),
      );
}
