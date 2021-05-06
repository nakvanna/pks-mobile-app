import 'package:flutter/material.dart';

Container customBackground({
  required List<Color> colors,
  required Alignment begin,
  required Alignment end,
  required Scaffold scaffold,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: colors,
      ),
    ),
    child: scaffold,
  );
}
