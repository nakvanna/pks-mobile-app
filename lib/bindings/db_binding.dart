import 'package:get/get.dart';
import 'package:pks_mobile/controllers/db_controller.dart';

class DbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DbController>(() => DbController());
  }
}
