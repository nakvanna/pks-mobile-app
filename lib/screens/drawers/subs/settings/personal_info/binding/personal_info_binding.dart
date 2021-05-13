import 'package:get/get.dart';
import 'package:pks_mobile/screens/drawers/subs/settings/personal_info/controller/personal_info_controller.dart';

class PersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PersonalInfoController());
  }
}
