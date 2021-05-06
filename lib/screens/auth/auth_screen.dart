import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/user_info.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/helper/text-style/button_text.dart';
import 'package:pks_mobile/helper/social_icon.dart';
import 'package:pks_mobile/helper/text-style/number_text.dart';
import 'package:pks_mobile/helper/text-style/simple_text.dart';
import 'package:pks_mobile/helper/text-style/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/custom_background.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AuthScreen extends GetView<LoginController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //International phone number
  final TextEditingController phoneNumberController = TextEditingController();
  final String? initialCountry = 'KH';
  final Rx<PhoneNumber> number = PhoneNumber(isoCode: 'KH').obs;
  //======End=======//
  //Login button click
  final RxBool googleLoading = false.obs;
  final RxBool appleLoading = false.obs;
  final RxBool phoneLoading = false.obs;

  final RxBool isValidate = false.obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize!;
    double fullWidth = SizeConfig.screenWidth!;
    return customBackground(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: kBgAuthScreen,
      scaffold: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
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
                      Padding(
                        padding: EdgeInsets.only(top: defaultSize),
                        child: Image.asset(
                          'assets/images/png/pks-logo.png',
                          height: defaultSize * 15.5,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      TitleText(label: 'login-with-these-accounts-below'),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Obx(
                                () => InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber number) {
                                    print(number.phoneNumber);
                                  },
                                  onInputValidated: (bool value) {
                                    isValidate.value = value;
                                  },
                                  selectorConfig: SelectorConfig(
                                    selectorType: PhoneInputSelectorType.DIALOG,
                                  ),
                                  hintText: 'phone-number'.tr,
                                  ignoreBlank: false,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  selectorTextStyle:
                                      TextStyle(color: Colors.black),
                                  initialValue: number.value,
                                  textFieldController: phoneNumberController,
                                  formatInput: false,
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  onSaved: (PhoneNumber number) {
                                    print('On Saved: $number');
                                  },
                                ),
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(minWidth: double.infinity),
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (isValidate.value) {
                                      await Get.toNamed(
                                        Routes.VERIFY_PHONE_NUMBER,
                                        arguments: await getPhoneNumber(
                                            phoneNumberController.text),
                                      );
                                    } else {
                                      Get.snackbar('Validate',
                                          'Phone number not correct!');
                                    }
                                  },
                                  child: ButtonText(
                                    label: 'login-with-phone-number',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      SimpleText(label: 'or-via', fontWeight: FontWeight.w600),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => googleLoading.value
                                ? RaisedButton.icon(
                                    onPressed: null,
                                    color: Colors.red,
                                    label: Text('Waiting...'),
                                    icon: SizedBox(
                                      width: defaultSize * 2,
                                      height: defaultSize * 2,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : RaisedButton.icon(
                                    onPressed: () async {
                                      googleLoading.value = true;
                                      await controller.googleSignIn();
                                      googleLoading.value = false;
                                    },
                                    color: Colors.red,
                                    label: Text('Google'),
                                    icon: Icon(SocialIcon.google),
                                  ),
                          ),
                          SizedBox(
                            width: defaultSize,
                          ),
                          Obx(() => appleLoading.value
                              ? RaisedButton.icon(
                                  onPressed: () {
                                    appleLoading.value = false;
                                  },
                                  label: Text('Waiting...'),
                                  icon: SizedBox(
                                    width: defaultSize * 2,
                                    height: defaultSize * 2,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : RaisedButton.icon(
                                  onPressed: () {
                                    appleLoading.value = true;
                                  },
                                  label: Text('Apple'),
                                  icon: Icon(SocialIcon.apple),
                                )),
                        ],
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      horizontalLine(width: fullWidth, height: defaultSize / 5),
                      SizedBox(
                        height: defaultSize,
                      ),
                      SimpleText(
                        label: 'any-problem-contact-us',
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NumberText(
                            label: '+855-964-962-424',
                            fontWeight: FontWeight.bold,
                          ),
                          NumberText(
                            label: '+855-85-598-999',
                            fontWeight: FontWeight.bold,
                          ),
                          NumberText(
                            label: '+855-81-598-999',
                            fontWeight: FontWeight.bold,
                          ),
                          NumberText(
                            label: '+855-68-598-999',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'KH');
    this.number.value = number;
    return number;
  }

  Padding horizontalLine({
    required double width,
    required double height,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: width,
          height: height,
          color: Colors.red.withOpacity(.3),
        ),
      );
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
