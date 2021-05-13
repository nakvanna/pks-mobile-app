import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/controllers/db_controller.dart';

class PersonalInfoController extends GetxController {
  final formKeyDisplayName = GlobalKey<FormState>();
  final formKeyBio = GlobalKey<FormState>();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPhoneNumber = GlobalKey<FormState>();

  late TextEditingController displayNameController,
      bioController,
      emailController,
      phoneNumberController;
  late DbController _db;
  final RxString displayName = ''.obs;
  final RxString bio = ''.obs;
  final RxList emails = [].obs;
  final RxList phoneNumbers = [].obs;
  final RxString photoURL = ''.obs;

  @override
  void onInit() async {
    displayNameController = TextEditingController();
    bioController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    _db = DbController();

    //If global variable is null. Let's fetch data once!
    if (kUserData.value == null) {
      kUserData.value = await _db.readUser(
        uid: kUID.value,
      ); //Get data from firestore and assign to global variable

      ///Assign after fetched data
      displayName.value = kUserData.value!.displayName!; //Assign display name.
      bio.value = kUserData.value!.bio!; //Assign bio.
      emails.value = kUserData.value!.emails!; //Assign email.
      phoneNumbers.value =
          kUserData.value!.phoneNumbers!; //Assign phone number.
      photoURL.value = kUserData.value!.photoURL!; //Assign photoURL
    } else {
      displayName.value = kUserData.value!
          .displayName!; //Assign display name after data already fetched.
      bio.value =
          kUserData.value!.bio!; //Assign bio after data already fetched.
      emails.value =
          kUserData.value!.emails!; //Assign email after data already fetched.
      phoneNumbers.value = kUserData.value!
          .phoneNumbers!; //Assign phone number after data already fetched.
      photoURL.value = kUserData
          .value!.photoURL!; //Assign photoURL after data already fetched.
    }
    super.onInit();
  }

  @override
  void onClose() {
    displayNameController.dispose();
    bioController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    _db.dispose();
    super.onClose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'provide-valid-email';
    }
    return null;
  }

  String? validateLength({required String field, required int length}) {
    String? message;
    if (field != '' && field.length < length)
      message = 'field-at-least-$length-characters'.tr;
    else if (field == '') message = 'please-input-your-field'.tr;
    return message;
  }

  void checkUpdateDisplayName() async {
    final isValid = formKeyDisplayName.currentState!.validate();
    if (!isValid) return;

    formKeyDisplayName.currentState!.save();
    bool update = await _db.updateUser(
      docId: kDocID.value,
      mapData: {'displayName': displayName.value},
    );
    if (update) {
      kUserData.value!.displayName = displayName.value;
      formKeyDisplayName.currentState!.reset();
    }
    _mySnackBar(update);
  }

  void checkUpdateBio() async {
    final isValid = formKeyBio.currentState!.validate();
    if (!isValid) return;

    formKeyBio.currentState!.save();
    bool update = await _db.updateUser(
      docId: kDocID.value,
      mapData: {'bio': bio.value},
    );
    if (update) {
      kUserData.value!.bio = bio.value;
      formKeyBio.currentState!.reset();
    }
    _mySnackBar(update);
  }

  void addUpdateEmail({required List newEmails}) async {
    try {
      final isValid = formKeyEmail.currentState!.validate();
      if (!isValid) return;
      formKeyEmail.currentState!.save();
      bool update = await _db.updateUser(
        docId: kDocID.value,
        mapData: {'emails': newEmails},
      );
      if (update) {
        kUserData.value!.emails = emails;
        formKeyEmail.currentState!.reset();
      }

      _mySnackBar(update);
    } catch (e) {
      print(e);
    }
  }

  void removeEmail({required List afterRemove}) async {
    try {
      bool update = await _db.updateUser(
        docId: kDocID.value,
        mapData: {'emails': afterRemove},
      );
      if (update) {
        kUserData.value!.emails = emails;
      }

      _mySnackBar(update);
    } catch (e) {}
  }

  void addUpdatePhoneNumbers({required List newPhoneNumbers}) async {
    try {
      final isValid = formKeyPhoneNumber.currentState!.validate();
      if (!isValid) return;
      formKeyPhoneNumber.currentState!.save();
      bool update = await _db.updateUser(
        docId: kDocID.value,
        mapData: {'phoneNumbers': newPhoneNumbers},
      );
      if (update) {
        kUserData.value!.phoneNumbers = phoneNumbers;
        formKeyPhoneNumber.currentState!.reset();
      }

      _mySnackBar(update);
    } catch (e) {
      print(e);
    }
  }

  void removePhoneNumber({required List afterRemove}) async {
    try {
      bool update = await _db.updateUser(
        docId: kDocID.value,
        mapData: {'phoneNumbers': afterRemove},
      );
      if (update) {
        kUserData.value!.phoneNumbers = phoneNumbers;
      }

      _mySnackBar(update);
    } catch (e) {}
  }

  void updatePhotoURL() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? _image;
    try {
      await Permission.photos.request();
      var _permission = await Permission.photos.status;
      if (_permission.isGranted) {
        _image = await _picker.getImage(source: ImageSource.gallery);
        File file = File(_image!.path);
        var snapshot = await _storage
            .ref()
            .child('${kDocID.value}/photoURL')
            .putFile(file);

        String _downloadPhotoURL = await snapshot.ref.getDownloadURL();

        bool _update = await _db.updateUser(
          docId: kDocID.value,
          mapData: {'photoURL': _downloadPhotoURL},
        );
        if (_update) {
          kUserData.value!.photoURL = _downloadPhotoURL;
          photoURL.value = _downloadPhotoURL;
        }
        _mySnackBar(_update);
      } else {
        Get.snackbar('Permission', 'Permission denied');
      }
    } catch (e) {
      print('Update photo url error on: $e');
    }
  }

  ///Snack Bar
  void _mySnackBar(bool success) {
    if (success)
      Get.snackbar(
        'update'.tr,
        'update-successful'.tr,
      );
    else
      Get.snackbar(
        'update'.tr,
        'update-unsuccessful'.tr,
        colorText: kInactiveColor,
      );
  }
}
