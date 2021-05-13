import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/modals/user_data.dart';

class UserListController extends GetxController {
  final DbController _db = DbController();

  Stream<QuerySnapshot<UserData?>>? usersStream() {
    return _db.readUsers();
  }
}
