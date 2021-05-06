import 'package:get/get.dart';
import 'package:pks_mobile/controllers/login-controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
  }
}
