import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/theme.dart';
import 'package:flutter/material.dart';

class MarkedLinkTileBackground extends StatelessWidget {
  const MarkedLinkTileBackground({
    Key key,
    this.direction = AxisDirection.right,
    @required this.link,
  })  : assert(
          direction == AxisDirection.right || direction == AxisDirection.left,
        ),
        assert(link != null),
        super(key: key);

  final AxisDirection direction;
  final Link link;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = primaryOrSecondaryFrom(theme);
    final onBackground = onPrimaryOrOnSecondaryFrom(theme);

    return Container(
      alignment: direction == AxisDirection.right
          ? Alignment.centerLeft
          : Alignment.centerRight,
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: link.isDone
          ? Text(
              link.verb.capitalizedInfinitive,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: onBackground),
            )
          : Text(
              link.verb.capitalizedPastParticle,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: onBackground),
            ),
    );
  }
}
