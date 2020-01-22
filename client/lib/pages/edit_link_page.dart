import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/link_form.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class EditLinkPage extends StatelessWidget {
  const EditLinkPage({
    Key key,
    @required this.link,
  }) : super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add'),
        ),
        body: SafeArea(
          child: LinkForm(
            link: link,
            onSubmit: (link) {
              Provider.of<LinkBloc>(
                context,
                listen: false,
              ).update.add(UpdateLinkEvent(
                    oldLink: this.link,
                    newLink: link,
                  ));

              Navigator.pop(context);
            },
            submitButtonLabel: 'Save',
          ),
        ),
      );
}
