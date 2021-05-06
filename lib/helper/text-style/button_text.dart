import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/size_config.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;
  @override
  Text build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    if (kLocaleCode == 'kh_KH') {
      return Text(
        label.tr,
        style: TextStyle(
          fontFamily: 'Battambang',
          fontWeight: FontWeight.w600,
          fontSize: defaultSize * 1.6,
        ),
      );
    } else {
      return Text(
        label.tr,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          fontSize: defaultSize * 1.8,
        ),
      );
    }
  }
}
