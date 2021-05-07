import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/helper/text-style/button_text.dart';
import 'package:pks_mobile/helper/text-style/link_text.dart';
import 'package:pks_mobile/helper/text-style/simple_text.dart';
import 'package:pks_mobile/helper/text-style/title_text.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/custom_button.dart';
import 'package:pks_mobile/widgets/separate_line.dart';

class VerifyPhoneNumber extends GetView<LoginController> {
  final String phoneNumber = '${Get.arguments}';
  final formKey = GlobalKey<FormState>();

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
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * .4,
                        child: Image.asset('assets/images/gif/otp.gif'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: defaultSize),
                        child: TitleText(label: 'phone-number-verification'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SimpleText(
                            label: "enter-the-code-sent-to",
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            width: defaultSize,
                          ),
                          SimpleText(
                            label: phoneNumber,
                            fontWeight: FontWeight.bold,
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
                            autoFocus: true,
                            appContext: _context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.red,
                              inactiveColor: Colors.black,
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
                            onCompleted: (String pin) async =>
                                await controller.onSubmitVerify(pin: pin),
                            onChanged: (String value) => print(value),
                          ),
                        ),
                      ),
                      separateLine(
                        width: screenWidth,
                        height: defaultSize * .2,
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
                      CustomButton(
                        label: "VERIFY",
                        color: Colors.purple,
                        onPressed: () async => await controller.onSubmitVerify(
                          pin: _pinPutController.text,
                        ),
                      )
                    ],
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
