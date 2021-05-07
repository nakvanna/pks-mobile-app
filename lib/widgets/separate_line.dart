import 'package:flutter/material.dart';

Padding separateLine({
  required double width,
  required double height,
  required Color color,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
