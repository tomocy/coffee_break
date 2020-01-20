import 'package:coffee_break/domain/models/link.dart';
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
  Widget build(BuildContext context) => Container(
        alignment: direction == AxisDirection.right
            ? Alignment.centerLeft
            : Alignment.centerRight,
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: link.isDone
            ? Text(
                'Todo',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              )
            : Text(
                'Done',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
      );
}
