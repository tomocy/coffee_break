import 'package:coffee_break/blocs/verb_bloc.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/add_verb_page.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerbForm extends StatefulWidget {
  const VerbForm({
    Key key,
    this.verb,
    this.onSubmit,
    this.submitButtonLabel,
  }) : super(key: key);

  final Verb verb;
  final Function(Verb) onSubmit;
  final String submitButtonLabel;

  @override
  _VerbFormState createState() => _VerbFormState();
}

class _VerbFormState extends State<VerbForm> {
  final _formKey = GlobalKey<FormState>();
  final _baseController = TextEditingController();
  final _pastParticleController = TextEditingController();

  @override
  void dispose() {
    _baseController.dispose();
    _pastParticleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _baseController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Base form',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pastParticleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Past particle form',
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: FlatButton.icon(
                  onPressed: () {
                    final verb = Verb(
                      _baseController.text,
                      _pastParticleController.text,
                    );
                    widget.onSubmit(verb);
                  },
                  color: primaryOrSecondaryFrom(Theme.of(context)),
                  icon: const Icon(Icons.sort_by_alpha),
                  label: Text(widget.submitButtonLabel),
                ),
              ),
            ],
          ),
        ),
      );
}

class VerbDropdownButtonFormField extends StatefulWidget {
  const VerbDropdownButtonFormField({Key key}) : super(key: key);

  @override
  _VerbDropdownButtonFormFieldState createState() =>
      _VerbDropdownButtonFormFieldState();
}

class _VerbDropdownButtonFormFieldState
    extends State<VerbDropdownButtonFormField> {
  Stream<List<Verb>> _verbs;
  VerbMenuItem _value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _verbs = Provider.of<VerbBloc>(
      context,
      listen: false,
    ).verbs;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Verb>>(
        stream: _verbs,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            Provider.of<VerbBloc>(
              context,
              listen: false,
            ).notify.add(null);
            return DropdownButtonFormField<void>(
              onChanged: (item) {},
              items: const [],
            );
          }

          return DropdownButtonFormField<VerbMenuItem>(
            isDense: true,
            value: _value,
            onChanged: (item) {
              if (item is _AddVerbMenuItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute<AddVerbPage>(
                    builder: (_) => const AddVerbPage(),
                  ),
                );
                return;
              }

              setState(() => _value = item);
            },
            decoration: const InputDecoration(
              labelText: 'Verb',
            ),
            items: snapshot.data
                .map((verb) => DropdownMenuItem(
                      value: VerbMenuItem(verb.base),
                      child: Text(verb.base),
                    ))
                .toList()
                  ..add(const DropdownMenuItem(
                    value: _AddVerbMenuItem(),
                    child: Text('Add verb'),
                  )),
          );
        },
      );
}

class _AddVerbMenuItem extends VerbMenuItem {
  const _AddVerbMenuItem() : super('');
}

class VerbMenuItem {
  const VerbMenuItem(this.value);

  final String value;

  @override
  bool operator ==(dynamic other) =>
      other is VerbMenuItem && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
