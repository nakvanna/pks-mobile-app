import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/size_config.dart';

class PhoneNumberText extends StatelessWidget {
  const PhoneNumberText({
    Key? key,
    required this.label,
    required this.fontWeight,
    required this.color,
  }) : super(key: key);

  final String label;
  final FontWeight fontWeight;
  final Color color;
  @override
  InkWell build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    if (kLocaleCode.value == 'kh_KH') {
      return InkWell(
        onTap: () {
          print(label);
        },
        child: Text(
          label.tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: fontWeight,
            fontSize: defaultSize * 2.2,
            color: color,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          print(label);
        },
        child: Text(
          label.tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: fontWeight,
            fontSize: defaultSize * 2.4,
            color: color,
          ),
        ),
      );
    }
  }
}
