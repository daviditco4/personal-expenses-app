import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  final String label;

  AdaptiveTextField({
    @required this.controller,
    @required this.onSubmitted,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            onSubmitted: onSubmitted,
            placeholder: label,
          )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
