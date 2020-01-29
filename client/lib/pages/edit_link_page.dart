import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/widgets/animated_backable_button.dart';
import 'package:coffee_break/pages/widgets/link_form.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';

class EditLinkPage extends StatelessWidget {
  const EditLinkPage({
    Key key,
    @required this.animation,
    @required this.link,
  })  : assert(animation != null),
        assert(link != null),
        super(key: key);

  final Animation<double> animation;
  final Link link;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: AnimatedBackableButton(animation: animation),
          title: const Text('Edit'),
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
