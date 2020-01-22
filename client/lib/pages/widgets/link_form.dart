import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';

class LinkForm extends StatefulWidget {
  const LinkForm({
    Key key,
    this.link,
    @required this.onSubmit,
    @required this.submitButtonLabel,
  }) : super(key: key);

  final Link link;
  final Function(Link) onSubmit;
  final String submitButtonLabel;

  @override
  _LinkFormState createState() => _LinkFormState();
}

class _LinkFormState extends State<LinkForm> {
  final _formKey = GlobalKey<FormState>();
  final _uriController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _uriController.text = widget.link?.uri;
  }

  @override
  void dispose() {
    _uriController.dispose();
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
                controller: _uriController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'URI',
                ),
                validator: (uri) => uri.isEmpty ? 'Please enter URI.' : null,
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

                    final link = widget.link != null
                        ? widget.link.copyWith(
                            uri: _uriController.text,
                          )
                        : Link.todo(uri: _uriController.text);
                    widget.onSubmit(link);
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
