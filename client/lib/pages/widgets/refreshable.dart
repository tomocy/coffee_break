import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Refreshable extends StatelessWidget {
  const Refreshable({
    Key key,
    @required this.onRefresh,
    @required this.child,
  })  : assert(onRefresh != null),
        assert(child != null),
        super(key: key);

  final Future<void> Function() onRefresh;
  final ScrollView child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidPullToRefresh(
      color: theme.colorScheme.background,
      backgroundColor: primaryOrSecondaryFrom(theme),
      onRefresh: onRefresh,
      child: child,
    );
  }
}
