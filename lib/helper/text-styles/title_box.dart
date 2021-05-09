import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/size_config.dart';

class TitleBox extends StatelessWidget {
  const TitleBox({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    if (kLocaleCode.value == 'kh_KH') {
      return Text(
        label.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Bokor',
          fontWeight: FontWeight.bold,
          fontSize: defaultSize * 2,
          color: color,
        ),
      );
    } else {
      return Text(
        label.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: defaultSize * 2.2,
          color: color,
        ),
      );
    }
  }
}
