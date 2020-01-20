import 'package:flutter/material.dart';

class UndoSnackBarAction extends SnackBarAction {
  const UndoSnackBarAction({Key key, VoidCallback onPressed})
      : super(
          key: key,
          onPressed: onPressed,
          label: 'UNDO',
        );
}
