import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/size_config.dart';

class SimpleText extends StatelessWidget {
  const SimpleText({
    Key? key,
    required this.label,
    required this.fontWeight,
    required this.color,
  }) : super(key: key);

  final String label;
  final FontWeight fontWeight;
  final Color color;
  @override
  Text build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    if (kLocaleCode.value == 'kh_KH') {
      return Text(
        label.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Battambang',
          fontWeight: fontWeight,
          fontSize: defaultSize * 1.6,
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
          fontWeight: fontWeight,
          fontSize: defaultSize * 1.8,
          color: color,
        ),
      );
    }
  }
}
