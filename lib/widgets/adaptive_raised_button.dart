import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String text;

  AdaptiveRaisedButton({
    @required this.onPressed,
    this.color,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: color ?? theme.primaryColor,
            child: Text(text),
          )
        : RaisedButton(
            onPressed: onPressed,
            color: color ?? theme.primaryColor,
            child: Text(text),
          );
  }
}
