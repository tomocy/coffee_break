import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/pages/widgets/verb_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddVerbPage extends StatelessWidget {
  const AddVerbPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add verb'),
        ),
        body: SafeArea(
          child: VerbForm(
            onSubmit: (verb) {
              Provider.of<VerbBloc>(
                context,
                listen: false,
              ).save.add(verb);

              Navigator.pop(
                context,
                verb,
              );
            },
            submitButtonLabel: 'Add',
          ),
        ),
      );
}
