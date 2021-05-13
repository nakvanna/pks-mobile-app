import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:pks_mobile/widgets/list_menu.dart';

class Settings extends GetView {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listMenuItems = [
      {
        'titleLabel': 'languages',
        'subtitleLabel': 'change-to-your-language.',
        // 'onTap': Routes.AUTH,
        'onTap': () {
          Get.toNamed(Routes
              .LANGUAGES); //fromAuth false to specify the user has login already.
        },
        'icon': Icons.arrow_forward_ios,
        'image': 'assets/images/png/translate32.png',
      },
      {
        'titleLabel': 'personal-info',
        'subtitleLabel': 'update-your-name-phone-number-and-other.',
        // 'onTap': Routes.AUTH,
        'onTap': () {
          Get.toNamed(Routes.PERSONAL_INFO);
        },
        'icon': Icons.arrow_forward_ios,
        'image': 'assets/images/png/profile32.png',
      },
    ];
    double defaultSize = SizeConfig.defaultSize!;
    return AppBackground(
      appBar: AppBar(
        centerTitle: true,
        title: TitleText(
          label: 'settings',
          color: kPrimaryColor,
        ),
      ),
      widget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Column(
            children: listMenuItems
                .map(
                  (e) => ListMenu(
                    image: Image.asset(e['image']),
                    titleLabel: e['titleLabel'],
                    subtitleLabel: e['subtitleLabel'],
                    onTap: e['onTap'],
                    icon: e['icon'],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
