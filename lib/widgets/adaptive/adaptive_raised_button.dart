import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  const AdaptiveRaisedButton({
    @required this.onPressed,
    this.color,
    @required this.text,
  });

  final Function onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: color ?? theme.primaryColor,
            child: Text(text),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                color ?? theme.primaryColor,
              ),
            ),
            child: Text(text),
          );
  }
}
