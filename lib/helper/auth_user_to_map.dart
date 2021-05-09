import 'package:firebase_auth/firebase_auth.dart';

///Convert auth user to map for necessary info of user login
Map<String, dynamic> convertUserToMap({User? user}) {
  var _user = user!;
  return {
    "displayName": _user.displayName,
    "email": [_user.email],
    "emailVerified": _user.emailVerified,
    "isAnonymous": _user.isAnonymous,
    "creationTime": _user.metadata.creationTime,
    "lastSignInTime": _user.metadata.lastSignInTime,
    "phoneNumber": [_user.phoneNumber],
    "photoURL": _user.photoURL,
    "uid": _user.uid,
    "bio": '',
  };
}
