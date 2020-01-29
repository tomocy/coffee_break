import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/pages/widgets/animated_backable_button.dart';
import 'package:coffee_break/pages/widgets/verb_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddVerbPage extends StatelessWidget {
  const AddVerbPage({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: AnimatedBackableButton(animation: animation),
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
