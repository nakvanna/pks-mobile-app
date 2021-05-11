import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:pks_mobile/widgets/field_update.dart';
import 'package:pks_mobile/widgets/profile_update.dart';

class PersonalInfo extends GetView<DbController> {
  final formKeyName = GlobalKey<FormState>();
  final formKeyBio = GlobalKey<FormState>();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPhoneNumber = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  /* Reactive variable on this screen */
  final RxString _displayName = ''.obs; //For reactive when update field
  final RxString _bio = ''.obs; //For reactive when update field
  final RxList _emails = [].obs; //For reactive when update field
  final RxList _phoneNumbers = [].obs; //For reactive when update field

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!; //default size on this context

    //Update display name field
    void _updateDisplayName() async {
      if (formKeyName.currentState!.validate()) {
        //Invoke update user
        await controller.updateUser(
          docId: kDocID.value,
          mapData: {'displayName': _displayNameController.text},
        ).then((value) {
          if (value) {
            kUserData.value!.displayName = _displayNameController
                .text; //Update display name to Global variable

            _displayName.value =
                _displayNameController.text; //Assign after updated

            _displayNameController.text = ''; //Clear display name field
            formKeyName.currentState!.reset();
            Get.snackbar('update'.tr, 'update-successful'.tr);
          } else {
            Get.snackbar(
              'update'.tr,
              'update-unsuccessful'.tr,
              colorText: kInactiveColor,
            );
          }
        });
      } else
        Get.snackbar(
          'validate'.tr,
          'please-correct-your-input'.tr,
          colorText: kInactiveColor,
        );
    }

    //Update bio field
    void _updateBio() async {
      if (formKeyBio.currentState!.validate()) {
        //Invoke update user
        await controller.updateUser(
          docId: kDocID.value,
          mapData: {'bio': _bioController.text},
        ).then((value) {
          if (value) {
            kUserData.value!.bio =
                _bioController.text; //Update bio to Global variable

            _bio.value = _bioController.text; //Assign after updated

            _bioController.text = ''; //Clear display name field
            formKeyBio.currentState!.reset();
            Get.snackbar('update'.tr, 'update-successful'.tr);
          } else
            Get.snackbar(
              'update'.tr,
              'update-unsuccessful'.tr,
              overlayColor: kInactiveColor,
            );
        });
      } else {
        Get.snackbar(
          'validate'.tr,
          'please-correct-your-input'.tr,
          colorText: kInactiveColor,
        );
      }
    }

    //Update email equal add more
    void _updateEmail(List emails) async {
      if (formKeyEmail.currentState!.validate()) {
        await controller.updateUser(
          docId: kDocID.value,
          mapData: {'email': emails},
        ).then((value) {
          if (value) {
            kUserData.value!.email = emails; //Update bio to Global variable

            _emails.value = emails; //Assign after updated

            _emailController.text = ''; //Clear display name field
            formKeyEmail.currentState!.reset();
            Get.snackbar('update'.tr, 'update-successful'.tr);
          } else {
            Get.snackbar(
              'update'.tr,
              'update-unsuccessful'.tr,
              overlayColor: kInactiveColor,
            );
          }
        });
      } else {
        Get.snackbar(
          'validate'.tr,
          'please-correct-your-input'.tr,
          colorText: kInactiveColor,
        );
      }
    }

    //Update phone number equal add more
    void _updatePhoneNumbers({required List phoneNumbers}) async {
      if (formKeyEmail.currentState!.validate()) {
        await controller.updateUser(
          docId: kDocID.value,
          mapData: {'phoneNumber': phoneNumbers},
        ).then((value) {
          if (value) {
            kUserData.value!.phoneNumber =
                phoneNumbers; //Update bio to Global variable
            formKeyPhoneNumber.currentState!.reset();
            Get.snackbar('update'.tr, 'update-successful'.tr);
          } else {
            Get.snackbar(
              'update'.tr,
              'update-unsuccessful'.tr,
              overlayColor: kInactiveColor,
            );
          }
        });
      } else {
        Get.snackbar(
          'validate'.tr,
          'please-correct-your-input'.tr,
          colorText: kInactiveColor,
        );
      }
    }

    return GetBuilder<DbController>(
      initState: (_) async {
        //If global variable is null. Let's fetch data once!
        if (kUserData.value == null) {
          kUserData.value = await controller.readUser(
            uid: kUID.value,
          ); //Get data from firestore and assign to global variable

          ///Assign after fetched data
          _displayName.value =
              kUserData.value!.displayName!; //Assign display name.
          _bio.value = kUserData.value!.bio!; //Assign bio.
          _emails.value = kUserData.value!.email!; //Assign email.
          _phoneNumbers.value = kUserData.value!.phoneNumber!; //Assign phone.
        } else {
          _displayName.value = kUserData
              .value!.displayName!; //Assign display name data already fetched.
          _bio.value = kUserData
              .value!.bio!; //Assign display name data already fetched.s
          _emails.value = kUserData.value!.email!; //Assign email.
          _phoneNumbers.value = kUserData.value!.phoneNumber!; //Assign phone.
        }
      },
      builder: (ctrl) {
        return AppBackground(
          appBar: AppBar(
            centerTitle: true,
            title: TitleText(
              label: 'personal-info',
              color: kPrimaryColor,
            ),
          ),
          widget: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(defaultSize * 2),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(defaultSize * 2),
                      //check before loading the form def null error
                      child: Obx(
                        () => kUserData.value != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileUpdate(
                                    onPressed: () {
                                      print('Image');
                                    },
                                    photoURL: kUserData.value!.photoURL,
                                  ),
                                  SimpleText(
                                    label: 'display-name',
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Form(
                                    key: formKeyName,
                                    child: FieldUpdate(
                                      onPressed: () {
                                        _updateDisplayName();
                                      },
                                      fieldController: _displayNameController,
                                      preIcon: Icons.person,
                                      sufIcon: Icons.done,
                                      valueShow: _displayName.value,
                                      emptyValueText: 'empty-name',
                                    ),
                                  ),
                                  SizedBox(
                                    height: defaultSize,
                                  ),
                                  SimpleText(
                                    label: 'bio',
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Form(
                                    key: formKeyBio,
                                    child: FieldUpdate(
                                      validateLength: 1,
                                      fieldController: _bioController,
                                      onPressed: () {
                                        _updateBio();
                                      },
                                      preIcon: Icons.info,
                                      sufIcon: Icons.done,
                                      valueShow: _bio.value,
                                      emptyValueText: 'empty-bio',
                                    ),
                                  ),
                                  SizedBox(
                                    height: defaultSize,
                                  ),
                                  SimpleText(
                                    label: 'contacts',
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // Text('$_emails'),
                                  // Text('$_phoneNumbers'),
                                  Form(
                                    key: formKeyEmail,
                                    child: ExpansionTile(
                                      title: SimpleText(
                                        label: "emails",
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: <Widget>[
                                        for (int i = 0; i < _emails.length; i++)
                                          ExpansionTile(
                                            title: Text('nakvanna@gmail.com'),
                                          ),
                                        Padding(
                                          padding: EdgeInsets.all(defaultSize),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: 'add-more...'.tr,
                                                    prefixIcon:
                                                        Icon(Icons.info),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Form(
                                    key: formKeyPhoneNumber,
                                    child: ExpansionTile(
                                      title: SimpleText(
                                        label: "phone-numbers",
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: <Widget>[
                                        for (int i = 0;
                                            i < _phoneNumbers.length;
                                            i++)
                                          if (_phoneNumbers[i]['type'] ==
                                              'primary')
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: defaultSize,
                                                right: defaultSize,
                                              ),
                                              child: Row(
                                                children: [
                                                  SimpleText(
                                                    label: _phoneNumbers[i]
                                                        ['phone'],
                                                    color: kPrimaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: defaultSize,
                                                  ),
                                                  Icon(
                                                    Icons.verified_outlined,
                                                  ),
                                                ],
                                              ),
                                            )
                                          else
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: defaultSize,
                                                right: defaultSize,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SimpleText(
                                                    label: _phoneNumbers[i]
                                                        ['phone'],
                                                    color: kPrimaryColor,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _phoneNumbers.removeAt(i);
                                                      _updatePhoneNumbers(
                                                        phoneNumbers:
                                                            _phoneNumbers,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outlined,
                                                      color: kInactiveColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _phoneNumberController,
                                                decoration: InputDecoration(
                                                  hintText: 'add-more...'.tr,
                                                  prefixIcon: Icon(
                                                      Icons.phone_outlined),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                _phoneNumbers.add({
                                                  'phone':
                                                      _phoneNumberController
                                                          .text,
                                                  'type': 'secondary',
                                                });
                                                _phoneNumberController.text =
                                                    ''; //Clear display name field
                                                _updatePhoneNumbers(
                                                    phoneNumbers:
                                                        _phoneNumbers);
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
