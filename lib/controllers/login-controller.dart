import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/global_variable.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxString _verificationCode = ''.obs;

  @override
  void onInit() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      kGoogleUser.value = account;
    });
    _googleSignIn.signInSilently();
    super.onInit();
  }

  ///Google sign in
  Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignIn = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignIn!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await _auth.signInWithCredential(credential);
      return _auth.currentUser;
    } catch (error) {
      print(error);
      Get.snackbar('Google sign-in error', '$error');
    }
  }

  ///Google Sign out
  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (error) {
      Get.snackbar('Google sign-out error', '$error');
    }
  }

  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth
              .signInWithCredential(credential)
              .then((value) => print(value));
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verify failed: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationCode.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationCode.value = verificationId;
        },
      );
    } catch (e) {
      print('Verify phone number error: $e');
    }
  }

  Future<User?> onSubmitVerify({required String pin}) async {
    try {
      await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationCode.value,
          smsCode: pin,
        ),
      );
      return _auth.currentUser;
    } catch (e) {
      print('On submit verify: $e');
      Get.snackbar('Verification', 'Your code invalid!');
    }
  }
}
