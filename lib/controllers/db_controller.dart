import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/modals/user_data.dart';

class DbController extends GetxController {
  final _fs = FirebaseFirestore.instance;
  final _userDataRef = FirebaseFirestore.instance
      .collection('Users')
      .withConverter<UserData?>(
        fromFirestore: (snapshots, _) => UserData.fromJson(snapshots.data()!),
        toFirestore: (userData, _) => userData!.toJson(),
      );

  /*CRUD*/
  //Create user
  Future<String?> createUser({required Map<String, dynamic> userMap}) async {
    String uid = userMap['uid'];
    try {
      bool? isExisting = await userExisting(uid: uid);
      if (!isExisting!) {
        final user = await _fs.collection('Users').add(userMap);
        return user.id;
      }
    } catch (e) {
      print('Create user error on: $e');
    }
  }

  //Read all users
  Stream<QuerySnapshot<UserData?>>? readUsers() {
    try {
      return _userDataRef.snapshots();
    } catch (e) {
      print('Read users error on: $e');
    }
  }

  //Read one by one specify on user's uid
  Future<UserData?> readUser({required String uid}) async {
    try {
      QuerySnapshot<UserData?> _userSnapshot =
          await _userDataRef.where('uid', isEqualTo: uid).get();
      QueryDocumentSnapshot<UserData?> snapshotDoc =
          _userSnapshot.docs[0]; //We have only one item in snapshot
      kDocID.value =
          snapshotDoc.id; //Assign to global variable for update next time
      UserData _userData = snapshotDoc.data()!; //data as UserData
      return _userData;
    } catch (e) {
      print('Read user error on: $e');
    }
  }

  Future<bool> updateUser(
      {required String docId, required Map<String, Object?> mapData}) async {
    try {
      await _userDataRef.doc(docId).update(mapData);
      return true;
    } catch (e) {
      print('Update user error on: $e');
      return false;
    }
  }

  //Check that user are already existed or not
  Future<bool?> userExisting({required String uid}) async {
    try {
      final _userData = await _userDataRef.where('uid', isEqualTo: uid).get();
      return _userData.docs.isNotEmpty;
    } catch (e) {
      print('Check is existing error on: $e');
    }
  }
}
