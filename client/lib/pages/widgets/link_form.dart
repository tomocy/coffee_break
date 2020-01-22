import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';

class LinkForm extends StatefulWidget {
  const LinkForm({
    Key key,
    @required this.onSubmit,
    @required this.submitButtonLabel,
  }) : super(key: key);

  final Function(TextEditingController) onSubmit;
  final String submitButtonLabel;

  @override
  _LinkFormState createState() => _LinkFormState();
}

class _LinkFormState extends State<LinkForm> {
  final _formKey = GlobalKey<FormState>();
  final _linkController = TextEditingController();

  @override
  void dispose() {
    _linkController.dispose();
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
                controller: _linkController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'link',
                ),
                validator: (link) => link.isEmpty ? 'Please enter link.' : null,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: FlatButton.icon(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    widget.onSubmit(_linkController);
                  },
                  color: primaryOrSecondaryFrom(Theme.of(context)),
                  icon: const Icon(Icons.link),
                  label: Text(widget.submitButtonLabel),
                ),
              ),
            ],
          ),
        ),
      );
}
