import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/modals/user_data.dart';

/*Reactive variable for use in the whole app*/
final Rx<GoogleSignInAccount?> kGoogleUser =
    Rx<GoogleSignInAccount?>(null); //Store google user
final RxString kLocaleCode = 'kh_KH'.obs; //Store locale code for translate
final RxString kUID = ''.obs; //Store UID
final RxString kDocID = ''.obs; //Store DocID
Rx<UserData?> kUserData = Rx<UserData?>(null); //Userdata
