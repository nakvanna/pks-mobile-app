import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pks_mobile/routes/app_pages.dart';

class VerifyPhoneNumber extends StatefulWidget {
  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final TextEditingController _pinPutController = TextEditingController();
  final String phoneNumber = '${Get.arguments}';
  String? _verificationCode;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  void _onSubmit(String pin) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationCode!,
        smsCode: pin,
      ))
          .then((value) {
        if (value.user != null) {
          Get.offAllNamed(Routes.HOME);
        }
      });
    } catch (e) {
      print('On submit error: $e');
    }
  }

  void _verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) Get.offAllNamed(Routes.HOME);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verify failed: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          print('verificationId: $verificationId');
          setState(() {
            _verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 30),
      );
    } catch (e) {
      print('Verify error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '$phoneNumber',
                    style: TextStyle(fontSize: 26),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: PinPut(
                      fieldsCount: 6,
                      onSubmit: (String pin) => _onSubmit(pin),
                      autofocus: true,
                      controller: _pinPutController,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.deepPurpleAccent.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
