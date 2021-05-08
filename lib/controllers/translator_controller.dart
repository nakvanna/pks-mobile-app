import 'package:get/get.dart';
import 'dart:ui';

class TranslationController extends GetxController {
  void changeLanguage({required String langCode, required String countryCode}) {
    Locale _local = Locale(langCode, countryCode);
    Get.updateLocale(_local);
  }
}
