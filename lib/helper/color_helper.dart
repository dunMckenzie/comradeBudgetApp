import 'package:flutter/material.dart';

Color getColor(BuildContext context, double percent) {
  if (percent >= 0.5) {
    return Theme.of(context).primaryColor;
  } else if (percent >= 0.25) {
    return Colors.green;
  }
  return Colors.red;
}