import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/controllers/shared-prefs-controller.dart';
import 'package:pks_mobile/helper/convert-authuser-to_user/authuser_to_user.dart';
import 'package:pks_mobile/helper/custom_icons/social_icon.dart';
import 'package:pks_mobile/helper/text-styles/number_text.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pks_mobile/widgets/custom_button.dart';
import 'package:pks_mobile/widgets/separate_line.dart';

class AuthScreen extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //International phone number
  final TextEditingController _phoneNumberController = TextEditingController();
  final String _initialCountry = 'KH';
  final Rx<PhoneNumber> _number = PhoneNumber(isoCode: 'KH').obs;
  //======End=======//
  //Login button click
  final RxBool _googleLoading = false.obs;
  final RxBool _appleLoading = false.obs;

  final RxBool isValidate = false.obs;
  final _db = Get.find<DbController>();

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    double screenWidth = SizeConfig.screenWidth!;
    return AppBackground(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes
                  .LANGUAGES); //fromAuth true to specify the user has no login yet.
            },
            icon: Image.asset('assets/images/png/translate32.png'),
            color: kPrimaryColor,
          )
        ],
      ),
      widget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              Image.asset(
                'assets/images/png/pks-logo.png',
                height: defaultSize * 15.5,
              ),
              SizedBox(
                height: defaultSize,
              ),
              TitleText(
                label: 'login-with-these-accounts-below',
                color: kSecondaryColor,
              ),
              SizedBox(
                height: defaultSize,
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Obx(
                        () => InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            //print(number.phoneNumber);
                          },
                          onInputValidated: (bool value) {
                            isValidate.value = value;
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          // hintText: 'phone-number'.tr,
                          inputDecoration: InputDecoration(
                            hintText: 'phone-number'.tr,
                            hintStyle: TextStyle(
                              color: kSecondaryColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryColor, width: 2.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: kPrimaryColor, width: 2.0),
                            ),
                          ),
                          countries: ['KH', 'TH'],
                          ignoreBlank: false,
                          errorMessage: 'លេខទូរស័ព្ទមិនត្រឹមត្រូវ',
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textStyle: TextStyle(
                            color: kSecondaryColor,
                            fontSize: defaultSize * 2,
                          ),
                          selectorTextStyle: TextStyle(
                            color: kSecondaryColor,
                            fontSize: defaultSize * 2,
                          ),
                          searchBoxDecoration: InputDecoration(
                            hintText: 'search-your-country'.tr,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: kPrimaryColor, width: 2.0),
                            ),
                          ),
                          initialValue: _number.value,
                          textFieldController: _phoneNumberController,
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 3,
                      ),
                      CustomButton(
                        onPressed: () async {
                          if (isValidate.value) {
                            await Get.toNamed(
                              Routes.VERIFY_PHONE_NUMBER,
                              arguments: await getPhoneNumber(
                                  _phoneNumberController.text),
                            );
                          } else {
                            Get.snackbar(
                                'Validate', 'Phone number not correct!');
                          }
                        },
                        label: 'login-with-phone-number',
                        btnColor: kSecondaryColor,
                        labelColor: kPrimaryColor,
                        width: screenWidth,
                        height: defaultSize * 5,
                        icon: Icon(Icons.phone_iphone),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: defaultSize,
              ),
              SimpleText(
                label: 'or-via',
                fontWeight: FontWeight.w600,
                color: kSecondaryColor,
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CustomButton(
                      onPressed: () async {
                        User? _user;
                        if (!_googleLoading.value) {
                          _googleLoading.value = true; //Assign loading true

                          _user =
                              await controller.googleSignIn(); //Google sign-in

                          await _db.createUser(
                            userMap: convertUserToMap(user: _user),
                          ); // Create user to firestore

                          await Get.find<SharedPrefsController>().setUID(
                              uid: _user!.uid); //Set uid to locale storage

                          await Get.offAllNamed(
                              Routes.HOME); // Go to home-screen
                          _googleLoading.value = false; //Assign loading false
                        }
                      },
                      icon: _googleLoading.value
                          ? SizedBox(
                              width: defaultSize * 2,
                              height: defaultSize * 2,
                              child: CircularProgressIndicator(),
                            )
                          : Icon(
                              SocialIcon.google,
                              color: kGoogleColor,
                            ),
                      label: _googleLoading.value ? 'Waiting' : 'Google',
                      btnColor: kSecondaryColor,
                      labelColor: kGoogleColor,
                      width: screenWidth * .3,
                      height: defaultSize * 4,
                    ),
                  ),
                  SizedBox(
                    width: defaultSize,
                  ),
                  Obx(
                    () => CustomButton(
                      onPressed: () async {
                        if (!_appleLoading.value) {
                          _appleLoading.value = true;
                        }
                      },
                      icon: _appleLoading.value
                          ? SizedBox(
                              width: defaultSize * 2,
                              height: defaultSize * 2,
                              child: CircularProgressIndicator(),
                            )
                          : Icon(
                              SocialIcon.apple,
                              color: kAppleColor,
                            ),
                      label: _appleLoading.value ? 'Waiting' : 'Apple',
                      btnColor: kPrimaryColor,
                      labelColor: kAppleColor,
                      width: screenWidth * .3,
                      height: defaultSize * 4,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              separateLine(
                width: screenWidth,
                height: defaultSize / 5,
                color: kPrimaryColor,
              ),
              SizedBox(
                height: defaultSize,
              ),
              SimpleText(
                label: 'any-problem-contact-us',
                fontWeight: FontWeight.w600,
                color: kSecondaryColor,
              ),
              SizedBox(
                height: defaultSize,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PhoneNumberText(
                    label: '+855-964-962-424',
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                  PhoneNumberText(
                    label: '+855-85-598-999',
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                  PhoneNumberText(
                    label: '+855-81-598-999',
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                  PhoneNumberText(
                    label: '+855-68-598-999',
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
        phoneNumber, _initialCountry);
    this._number.value = number;
    return number.toString();
  }
}

class SocialBtn extends StatelessWidget {
  const SocialBtn({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.isLoading,
  }) : super(key: key);

  final Color color;
  final Function onPressed;
  final String label;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return RaisedButton.icon(
      color: color,
      onPressed: () => isLoading ? null : onPressed,
      label: Text(label),
      icon: isLoading
          ? SizedBox(
              width: defaultSize * 2,
              height: defaultSize * 2,
              child: CircularProgressIndicator(),
            )
          : Icon(icon),
    );
  }
}
