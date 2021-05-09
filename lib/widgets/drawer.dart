import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/helper/styles/simplyTextStyle.dart';
import 'package:pks_mobile/helper/styles/titleBoxTextStyle.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/custom_button.dart';

class MyDrawer extends GetView {
  Drawer build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    double screenHeight = SizeConfig.screenHeight!;
    List<Map<String, dynamic>> listItems = [
      {
        'onTap': () {
          Navigator.of(context).pop();
          Get.toNamed(Routes.SETTINGS);
        },
        'image': 'assets/images/png/settings32.png',
        'label': 'settings',
      },
      {
        'onTap': () {},
        'image': 'assets/images/png/information32.png',
        'label': 'about-school',
      },
      {
        'onTap': () {},
        'image': 'assets/images/png/accurate32.png',
        'label': 'about-app',
      },
      {
        'onTap': () {},
        'image': 'assets/images/png/social-media32.png',
        'label': 'share',
      },
      {
        'onTap': () async {
          Get.defaultDialog(
            backgroundColor: kSecondaryColor,
            title: 'logout'.tr,
            titleStyle: titleBoxTextStyle(
              defaultSize: defaultSize,
              color: kInactiveColor,
            ),
            content: SimpleText(
              label: 'do-you-want-to-logout?',
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
            confirm: CustomButton(
              onPressed: () async {
                await Get.find<LoginController>().googleSignOut();
                Get.offAllNamed(Routes.AUTH);
              },
              label: 'yes',
              btnColor: kActiveColor,
              labelColor: kPrimaryColor,
              width: defaultSize * 11,
              height: defaultSize * 3,
            ),
            cancel: CustomButton(
              onPressed: () {
                Get.back();
              },
              label: 'no',
              btnColor: kInactiveColor,
              labelColor: kSecondaryColor,
              width: defaultSize * 11,
              height: defaultSize * 3,
            ),
          );
        },
        'image': 'assets/images/png/logout32.png',
        'label': 'logout',
      },
    ];
    return Drawer(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: kSecondaryColor,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight / 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: kBgColors,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                          "assets/images/png/profile-placeholder.png"),
                      title: Text('NAK VANNA'),
                      subtitle: Text('nakvanna@gmail.com'),
                    ),
                    SizedBox(
                      height: defaultSize / 2,
                    ),
                    Text('BIO'),
                    Text('Hello im a student of a school in a village!')
                  ],
                ),
              ),
              Opacity(
                opacity: .75,
                child: Column(
                  children: listItems
                      .map(
                        (e) => drawerMenu(
                          onTap: e['onTap'],
                          image: e['image'],
                          label: e['label'],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell drawerMenu(
      {required Function onTap, required String image, required String label}) {
    return InkWell(
      onTap: () => onTap(),
      child: ListTile(
        leading: Image.asset(image),
        title: SimpleText(
          label: label,
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
