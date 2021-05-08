import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController extends GetxController {
  static String localeCodeKey = 'LOCALE_CODE';

  Future<void> setLocaleCode({required String langCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(localeCodeKey, langCode);
    kLocaleCode.value = langCode;
  }

  Future<void> getLocaleCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kLocaleCode.value = prefs.getString(localeCodeKey) ?? 'kh_KH';
  }
}
