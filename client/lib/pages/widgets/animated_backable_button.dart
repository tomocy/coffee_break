import 'package:flutter/material.dart';

class AnimatedBackableButton extends StatelessWidget {
  const AnimatedBackableButton({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Navigator.canPop(context)
      ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AnimatedIcon(
            progress: animation,
            icon: AnimatedIcons.menu_arrow,
          ),
        )
      : Container();
}
