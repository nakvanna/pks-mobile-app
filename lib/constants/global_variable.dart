import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

///Reactive variable
final Rx<GoogleSignInAccount?> kGoogleUser = Rx<GoogleSignInAccount?>(null);
final RxString kLocaleCode = 'kh_KH'.obs;
