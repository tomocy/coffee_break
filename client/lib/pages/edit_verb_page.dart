import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/widgets/verb_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditVerbPage extends StatelessWidget {
  const EditVerbPage({
    Key key,
    @required this.verb,
  })  : assert(verb != null),
        super(key: key);

  final Verb verb;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit verb'),
        ),
        body: SafeArea(
          child: VerbForm(
            verb: verb,
            onSubmit: (verb) {
              Provider.of<VerbBloc>(
                context,
                listen: false,
              ).update.add(UpdateVerbEvent(
                    oldVerb: this.verb,
                    newVerb: verb,
                  ));

              Navigator.pop(context);
            },
            submitButtonLabel: 'Save',
          ),
        ),
      );
}
