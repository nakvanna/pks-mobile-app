import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/controllers/shared-prefs-controller.dart';
import 'package:pks_mobile/controllers/translator_controller.dart';
import 'package:pks_mobile/helper/split_locale_code.dart';
import 'package:pks_mobile/helper/text-style/simple_text.dart';
import 'package:pks_mobile/helper/text-style/title_text.dart';
import 'package:pks_mobile/widgets/app_background.dart';

class Languages extends GetView<TranslationController> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listMenuItems = [
      {
        'localeCode': 'kh_KH',
        'isCheck': false,
        'language': 'ភាសាខ្មែរ',
        'image': 'assets/images/png/cambodia32.png',
      },
      {
        'localeCode': 'en_US',
        'isCheck': false,
        'language': 'english',
        'image': 'assets/images/png/united-kingdom32.png',
      },
    ];

    return AppBackground(
      appBar: AppBar(
        centerTitle: true,
        title: TitleText(
          label: 'languages',
          color: kPrimaryColor,
        ),
      ),
      widget: ListView.separated(
        itemBuilder: (context, index) {
          Map<String, dynamic> _item = listMenuItems[index];
          return Obx(() {
            return CheckboxListTile(
              secondary: Image.asset(_item['image']),
              title: SimpleText(
                label: _item['language'],
                fontWeight: FontWeight.w700,
                color: kPrimaryColor,
              ),
              value: kLocaleCode.value == _item['localeCode'],
              onChanged: (value) async {
                await Get.find<SharedPrefsController>().setLocaleCode(
                  langCode: _item['localeCode'],
                );
                String langCode = getLangCode(localeCode: _item['localeCode']);
                String countryCode =
                    getCountryCode(localeCode: _item['localeCode']);
                controller.changeLanguage(
                    langCode: langCode, countryCode: countryCode);
              },
            );
          });
        },
        separatorBuilder: (_, __) => Divider(height: 0.5),
        itemCount: listMenuItems.length,
      ),
    );
  }
}
