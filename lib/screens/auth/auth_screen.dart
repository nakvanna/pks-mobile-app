import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants.dart';
import 'package:pks_mobile/helper/social-icon.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/custom_background.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AuthScreen extends GetView {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String? initialCountry = 'KH';
  Rx<PhoneNumber> number = PhoneNumber(isoCode: 'KH').obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize!;
    double fullWidth = SizeConfig.screenWidth!;
    return customBackground(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: kBackgroundColors,
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
                      Text(
                        'ចុះឈ្មោះដោយប្រើគណនីខាងក្រោម',
                        style: TextStyle(
                            fontFamily: 'Bokor', fontSize: defaultSize * 2.4),
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
                                    print(value);
                                  },
                                  selectorConfig: SelectorConfig(
                                    selectorType: PhoneInputSelectorType.DIALOG,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  selectorTextStyle:
                                      TextStyle(color: Colors.black),
                                  initialValue: number.value,
                                  textFieldController: controller,
                                  formatInput: false,
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  // inputBorder: OutlineInputBorder(),
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
                                  onPressed: () {
                                    getPhoneNumber('+855969392312');
                                  },
                                  child: Text(
                                    'ចុះឈ្មោះតាមលេខទូរស័ព្ទ',
                                    style: TextStyle(
                                        fontFamily: 'Bokor',
                                        fontSize: defaultSize * 1.6),
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
                      Text(
                        'ឬតាមរយៈ',
                        style: TextStyle(
                            fontFamily: 'Bokor', fontSize: defaultSize * 1.6),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton.icon(
                            color: Colors.red,
                            onPressed: () {},
                            label: Text('Google'),
                            icon: Icon(SocialIcon.google),
                          ),
                          SizedBox(
                            width: defaultSize,
                          ),
                          RaisedButton.icon(
                            onPressed: () {},
                            label: Text('Apple'),
                            icon: Icon(SocialIcon.apple),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      horizontalLine(width: fullWidth, height: defaultSize / 5),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        'មានបញ្ហាមិនអាចចូលប្រើប្រាស់បាន សូមទាក់ទងមកលេខ',
                        style: TextStyle(
                          fontFamily: 'Bokor',
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        '+855 964 962 424',
                        style: TextStyle(
                          fontFamily: 'Bokor',
                          fontSize: defaultSize * 1.4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        '+855 85 598 999',
                        style: TextStyle(
                            fontFamily: 'Bokor',
                            fontSize: defaultSize * 1.4,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        '+855 81 598 999',
                        style: TextStyle(
                            fontFamily: 'Bokor',
                            fontSize: defaultSize * 1.4,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        '+855 68 598 999',
                        style: TextStyle(
                          fontFamily: 'Bokor',
                          fontSize: defaultSize * 1.4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'KH');
    this.number.value = number;
    print(number);
  }

  Widget horizontalLine({required double width, required double height}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: width,
          height: height,
          color: Colors.red.withOpacity(.3),
        ),
      );
}
