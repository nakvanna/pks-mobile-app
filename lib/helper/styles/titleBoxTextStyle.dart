import 'package:flutter/material.dart';
import 'package:pks_mobile/constants/global_variable.dart';

///Allow the style only
TextStyle titleBoxTextStyle({
  required double defaultSize,
  required Color color,
}) {
  if (kLocaleCode.value == 'kh_KH') {
    return TextStyle(
      fontFamily: 'Battambang',
      fontWeight: FontWeight.bold,
      fontSize: defaultSize * 2,
      color: color,
    );
  } else {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      fontSize: defaultSize * 2.2,
      color: color,
    );
  }
}
