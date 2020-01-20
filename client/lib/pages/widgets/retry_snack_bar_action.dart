import 'package:flutter/material.dart';

class RetrySnackBarAction extends SnackBarAction {
  const RetrySnackBarAction({
    Key key,
    VoidCallback onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          label: 'RETRY',
        );
}
