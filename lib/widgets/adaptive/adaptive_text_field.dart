import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  const AdaptiveTextField({
    @required this.controller,
    @required this.onSubmitted,
    this.keyboardType,
    @required this.label,
  });

  final TextEditingController controller;
  final Function onSubmitted;
  final TextInputType keyboardType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            placeholder: label,
          )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            decoration: InputDecoration(labelText: label),
          );
  }
}
