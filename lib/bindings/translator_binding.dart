import 'package:get/get.dart';
import 'package:pks_mobile/controllers/translator_controller.dart';

class TranslationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranslationController>(() => TranslationController());
  }
}
