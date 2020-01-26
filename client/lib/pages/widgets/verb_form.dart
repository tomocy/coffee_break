import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/search_verbs_page.dart';
import 'package:coffee_break/pages/widgets/flat_button_form_field.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    super.initState();
    _baseController.text = widget.verb?.base;
    _pastParticleController.text = widget.verb?.pastParticle;
  }

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

class SelectVerbButtonFormField extends StatelessWidget {
  const SelectVerbButtonFormField({
    Key key,
    this.verb,
    this.validator,
    this.onSelected,
  }) : super(key: key);

  final Verb verb;
  final String Function(Verb) validator;
  final Function(Verb) onSelected;

  @override
  Widget build(BuildContext context) => FlatButtonFormField<Verb>(
        value: verb,
        onPressed: (oldVerb) async {
          final verb = await showSearch(
            context: context,
            delegate: SearchVerbsPage(),
            query: oldVerb != null ? oldVerb.base : '',
          );
          if (verb == null) {
            return oldVerb;
          }

          if (onSelected != null) {
            onSelected(verb);
          }
          return verb;
        },
        validator: validator,
        labelBuilder: (verb) => verb != null ? 'Verb' : 'Select verb',
        builder: (verb) => verb != null ? Text(verb.base) : null,
      );
}
