import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton({
    @required this.onPressed,
    this.textColor,
    @required this.text,
  });

  final Function onPressed;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                textColor ?? Theme.of(context).primaryColor,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
