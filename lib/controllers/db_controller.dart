import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/modals/user_data.dart';

class DbController extends GetxController {
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final _fs = FirebaseFirestore.instance;

  final _userDataRef = FirebaseFirestore.instance
      .collection('Users')
      .withConverter<UserData?>(
        fromFirestore: (snapshots, _) => UserData.fromJson(snapshots.data()!),
        toFirestore: (userData, _) => userData!.toJson(),
      );

  @override
  void onInit() async {
    kUserInfo.value = await readUser(uid: _uid);
    print(kUserInfo.value);
    super.onInit();
  }

  createUser({required Map<String, dynamic> userMap}) async {
    String uid = userMap['uid'];
    try {
      bool? isExisting = await userExisting(uid: uid);
      if (!isExisting!) {
        await _fs
            .collection('Users')
            .add(userMap)
            .then((value) => print('Create user: $value'));
      }
    } catch (e) {
      print('Create user error on: $e');
    }
  }

  Stream<QuerySnapshot<UserData?>>? readUsers() {
    try {
      return _userDataRef.snapshots();
    } catch (e) {
      print('Read users error on: $e');
    }
  }

  readUser({required String uid}) {
    try {
      return _userDataRef.where('uid', isEqualTo: uid).get();
    } catch (e) {
      print('Read user error on: $e');
    }
  }

  Future<bool?> userExisting({required String uid}) async {
    try {
      final _userData = await _userDataRef.where('uid', isEqualTo: uid).get();
      return _userData.docs.isNotEmpty;
    } catch (e) {
      print('Check is existing error on: $e');
    }
  }
}
