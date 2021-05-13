import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/controllers/shared-prefs-controller.dart';
import 'package:pks_mobile/helper/styles/titleBoxTextStyle.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/widgets/custom_button.dart';

class MyDrawerController extends GetxController {
  final DbController _db = DbController();
  final LoginController _login = LoginController();

  @override
  void onInit() async {
    if (kUserData.value == null) {
      kUserData.value = await _db.readUser(
        uid: kUID.value,
      ); //Get data from firestore and assign to global variable
    }
    super.onInit();
  }

  void onSetting(BuildContext _) {
    Navigator.of(_).pop();
    Get.toNamed(Routes.SETTINGS);
  }

  void onLogout(double defaultSize) async {
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
          await _login.googleSignOut(); //Google sign out
          await Get.find<SharedPrefsController>()
              .clearPrefs(); //Clear all locale storage
          Get.offAllNamed(Routes.AUTH); //Go to auth screen

          /* Clear Global Data */
          kUID.value = '';
          kDocID.value = '';
          kUserData.value = null;
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
  }
}
