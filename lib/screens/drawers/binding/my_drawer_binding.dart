import 'package:get/get.dart';
import 'package:pks_mobile/screens/drawers/controller/my_drawer_controller.dart';

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyDrawerController());
  }
}
