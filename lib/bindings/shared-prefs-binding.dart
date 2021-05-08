import 'package:get/get.dart';
import 'package:pks_mobile/controllers/shared-prefs-controller.dart';

class SharedPrefsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedPrefsController>(() => SharedPrefsController());
  }
}
