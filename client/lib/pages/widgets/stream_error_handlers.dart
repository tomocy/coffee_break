import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/pages/page.dart';
import 'package:coffee_break/pages/widgets/retry_snack_bar_action.dart';
import 'package:coffee_break/pages/widgets/stream_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamErrorHandlers extends StatelessWidget {
  const StreamErrorHandlers({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => StreamErrorHandler<List<Link>>(
        stream: Provider.of<LinkBloc>(
          context,
          listen: false,
        ).links,
        onError: (error) => showSnackBar(
          context,
          SnackBar(
            action: RetrySnackBarAction(
              onPressed: () => Provider.of<LinkBloc>(
                context,
                listen: false,
              ).fetch.add(null),
            ),
            content: Text(error.toString()),
          ),
        ),
        child: child,
      );
}
