import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-style/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:pks_mobile/widgets/list_menu.dart';

class Settings extends GetView {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listMenuItems = [
      {
        'titleLabel': 'language',
        'subtitleLabel': 'change to your language.',
        // 'onTap': Routes.AUTH,
        'onTap': () {
          Get.toNamed(Routes.LANGUAGES);
        },
        'icon': Icons.arrow_forward_ios,
        'image': 'assets/images/png/translate32.png',
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
                    image: e['image'],
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
