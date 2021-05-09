import 'package:flutter/material.dart';
import 'package:pks_mobile/constants/global_variable.dart';

///Allow the style only
TextStyle simpleTextStyle(
    {required double defaultSize,
    required FontWeight fontWeight,
    required Color color}) {
  if (kLocaleCode.value == 'kh_KH') {
    return TextStyle(
      fontFamily: 'Battambang',
      fontWeight: fontWeight,
      fontSize: defaultSize * 1.6,
      color: color,
    );
  } else {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
      fontSize: defaultSize * 1.8,
      color: color,
    );
  }
}
