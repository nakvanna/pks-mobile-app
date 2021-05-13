import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/helper/text-styles/title_box.dart';
import 'package:pks_mobile/screens/drawers/controller/my_drawer_controller.dart';
import 'package:pks_mobile/size_config.dart';

class MyDrawer extends GetView<MyDrawerController> {
  Drawer build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    double screenHeight = SizeConfig.screenHeight!;
    List<Map<String, dynamic>> listItems = [
      {
        'onTap': () => controller.onSetting(context),
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
        'onTap': () => controller.onLogout(defaultSize),
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
                height: screenHeight / 5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: kBgColors,
                  ),
                ),
                child: Obx(
                  () => kUserData.value != null
                      ? Column(
                          children: [
                            ListTile(
                              leading: kUserData.value!.photoURL! != ''
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          kUserData.value!.photoURL!),
                                    )
                                  : Image.asset(
                                      'assets/images/png/profile-placeholder.png',
                                      width: defaultSize * 10,
                                      height: defaultSize * 10,
                                    ),
                              title: TitleBox(
                                color: kSecondaryColor,
                                label: kUserData.value!.displayName! != ''
                                    ? kUserData.value!.displayName!
                                    : 'empty-value',
                              ),
                            ),
                            SizedBox(
                              height: defaultSize / 2,
                            ),
                            SimpleText(
                              label: 'BIO',
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SimpleText(
                              label: kUserData.value!.bio!,
                              color: kSecondaryColor,
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
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
