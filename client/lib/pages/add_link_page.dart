import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/pages/widgets/link_form.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class AddLinkPage extends StatelessWidget {
  const AddLinkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add link'),
        ),
        body: SafeArea(
          child: LinkForm(
            onSubmit: (link) {
              Provider.of<LinkBloc>(
                context,
                listen: false,
              ).save.add(link);

              Navigator.pop(context);
            },
            submitButtonLabel: 'Add',
          ),
        ),
      );
}
