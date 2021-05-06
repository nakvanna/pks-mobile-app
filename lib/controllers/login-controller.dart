import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/user_info.dart';
import 'package:pks_mobile/routes/app_pages.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      googleUser.value = account;
    });
    _googleSignIn.signInSilently();

    super.onInit();
  }

  ///Google sign in
  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignIn = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleSignIn!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await _auth.signInWithCredential(credential).then(
            (value) => Get.offAllNamed(Routes.HOME),
          );
    } catch (error) {
      print(error);
      Get.snackbar('Google sign-in error', '$error');
    }
  }

  ///Google Sign out
  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      Get.snackbar('Google sign-out error', '$error');
    }
  }
}
