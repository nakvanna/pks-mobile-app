import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/modals/user_data.dart';

///Reactive variable
final Rx<GoogleSignInAccount?> kGoogleUser = Rx<GoogleSignInAccount?>(null);
final RxString kLocaleCode = 'kh_KH'.obs;
final Rx<UserData?> kUserInfo = Rx<UserData?>(null);
