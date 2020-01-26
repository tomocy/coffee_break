import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/widgets/flat_button_form_field.dart';
import 'package:coffee_break/pages/widgets/verb_form.dart';
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
  Verb _selectedVerb;
  DateTime _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _uriController.text = widget.link?.uri;
    _selectedVerb = widget.link?.verb;
    _selectedDueDate = widget.link?.dueDate;
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
              SelectVerbButtonFormField(
                verb: _selectedVerb,
                validator: (verb) =>
                    verb == null ? 'Please select verb.' : null,
                onSelected: (verb) => setState(() => _selectedVerb = verb),
              ),
              const SizedBox(height: 16),
              SelectDueDateButtonFormField(
                dueDate: _selectedDueDate,
                onSelected: (dueDate) =>
                    setState(() => _selectedDueDate = dueDate),
              ),
              const SizedBox(height: 32),
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
                            verb: _selectedVerb,
                            dueDate: _selectedDueDate,
                          )
                        : Link.todo(
                            uri: _uriController.text,
                            verb: _selectedVerb,
                            dueDate: _selectedDueDate,
                          );
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

class SelectDueDateButtonFormField extends StatelessWidget {
  const SelectDueDateButtonFormField({
    Key key,
    @required this.dueDate,
    @required this.onSelected,
  }) : super(key: key);

  final DateTime dueDate;
  final Function(DateTime) onSelected;

  @override
  Widget build(BuildContext context) => FlatButtonFormField<DateTime>(
        value: dueDate,
        onPressed: (olddueDate) async {
          final now = DateTime.now();
          final dueDate = await showDatePicker(
            context: context,
            initialDate: this.dueDate ?? now,
            firstDate: DateTime(now.year >= 1 ? now.year - 1 : 0),
            lastDate: DateTime(now.year + 1),
          );
          if (dueDate == null) {
            return olddueDate;
          }

          if (onSelected != null) {
            onSelected(dueDate);
          }
          return dueDate;
        },
        labelBuilder: (dueDate) =>
            dueDate != null ? 'Due date' : 'Select due date',
        builder: (dueDate) {
          if (dueDate == null) {
            return null;
          }

          final local = dueDate.toLocal();
          return Text('${local.year}/${local.month}/${local.day}');
        },
      );
}
