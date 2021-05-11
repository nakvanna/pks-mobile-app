import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/controllers/shared-prefs-controller.dart';
import 'package:pks_mobile/helper/convert-authuser-to_user/authuser_to_user.dart';
import 'package:pks_mobile/helper/text-styles/link_text.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/custom_button.dart';
import 'package:pks_mobile/widgets/separate_line.dart';

class VerifyPhoneNumber extends GetView<LoginController> {
  final String phoneNumber = '${Get.arguments}';
  final formKey = GlobalKey<FormState>();
  final _db = Get.find<DbController>();
  final RxBool _phoneLoading = false.obs;

  @override
  Widget build(BuildContext _context) {
    double defaultSize = SizeConfig.defaultSize!;
    double screenWidth = SizeConfig.screenWidth!;
    double screenHeight = SizeConfig.screenHeight!;

    return GetBuilder<LoginController>(
      initState: (_) async {
        await controller.verifyPhoneNumber(phoneNumber: Get.arguments);
      },
      builder: (context) {
        TextEditingController _pinPutController = TextEditingController();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: double.infinity),
                      ),
                    ),
                    Image.asset(
                      'assets/images/png/building.png',
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(defaultSize),
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * .4,
                          child: Image.asset('assets/images/gif/otp.gif'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: defaultSize),
                          child: TitleText(
                            label: 'phone-number-verification',
                            color: kPrimaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SimpleText(
                              label: "enter-the-code-sent-to",
                              fontWeight: FontWeight.normal,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: defaultSize,
                            ),
                            SimpleText(
                              label: phoneNumber,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: defaultSize * 3,
                        ),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultSize,
                                horizontal: defaultSize * 3),
                            child: PinCodeTextField(
                              appContext: _context,
                              pastedTextStyle: TextStyle(
                                color: kLinkColor,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.circle,
                                activeFillColor: kSecondaryColor,
                                inactiveFillColor: kSecondaryColor,
                                activeColor: kActiveColor,
                                inactiveColor: kInactiveColor,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              textStyle: TextStyle(fontSize: 20, height: 1.6),
                              enableActiveFill: true,
                              controller: _pinPutController,
                              keyboardType: TextInputType.number,
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (String pin) async {
                                User? _user;
                                _phoneLoading.value = true;
                                _user =
                                    await controller.onSubmitVerify(pin: pin);
                                await _db.createUser(
                                  userMap: convertUserToMap(user: _user),
                                ); //Create user by phone login

                                await Get.find<SharedPrefsController>().setUID(
                                    uid:
                                        _user!.uid); //Set uid to locale storage

                                await Get.offAllNamed(Routes.HOME);
                                _phoneLoading.value = false;
                              },
                              onChanged: (String value) => print(value),
                            ),
                          ),
                        ),
                        separateLine(
                          width: screenWidth,
                          height: defaultSize * .3,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SimpleText(
                              label: "didn't-receive-the-code?",
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: defaultSize,
                            ),
                            LinkText(
                              label: "RESEND",
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        Obx(
                          () => CustomButton(
                            onPressed: () async {
                              // User? _user;
                              if (!_phoneLoading.value) {
                                // _phoneLoading.value = true;
                                // await controller.onSubmitVerify(
                                //   pin: _pinPutController.text,
                                // );
                                // await _db.createUser(
                                //   userMap: convertUserToMap(user: _user),
                                // );
                                // await Get.offAllNamed(Routes.HOME);
                                // _phoneLoading.value = false;
                              }
                            },
                            icon: _phoneLoading.value
                                ? SizedBox(
                                    width: defaultSize * 2,
                                    height: defaultSize * 2,
                                    child: CircularProgressIndicator(),
                                  )
                                : Icon(
                                    Icons.verified,
                                    color: kSecondaryColor,
                                  ),
                            label: _phoneLoading.value ? 'Waiting' : 'VERIFY',
                            width: screenWidth,
                            height: defaultSize * 5,
                            btnColor: kPrimaryColor,
                            labelColor: kSecondaryColor,
                          ),
                        ),
                        /*CustomButton(
                          label: "VERIFY",
                          icon: Icon(
                            Icons.verified,
                            color: kSecondaryColor,
                          ),
                          width: screenWidth,
                          height: defaultSize * 5,
                          btnColor: kPrimaryColor,
                          labelColor: kSecondaryColor,
                          onPressed: () async {
                            await controller.onSubmitVerify(
                              pin: _pinPutController.text,
                            );
                          },
                        )*/
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
