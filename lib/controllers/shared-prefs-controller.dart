import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController extends GetxController {
  static String localeCodeKey = 'LOCALE_CODE_KEY';
  static String uidKey = 'UID_KEY';

  @override
  void onInit() async {
    print('Hello from shared prefs init');
    super.onInit();
  }

  Future<void> setLocaleCode({required String langCode}) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(localeCodeKey, langCode);
    kLocaleCode.value = langCode;
  }

  void getLocaleCode() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    kLocaleCode.value = _prefs.getString(localeCodeKey) ?? 'kh_KH';
  }

  Future<void> setUID({required String uid}) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(uidKey, uid);
    kUID.value = uid;
  }

  void getUID() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    kUID.value = _prefs.getString(uidKey) ?? '';
  }

  //Clear prefs
  Future<void> clearPrefs() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
  }
}
