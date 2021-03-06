import 'package:firebase_auth/firebase_auth.dart';

///Convert authentication.currentUser to users in firestore for necessary info
Map<String, dynamic> convertUserToMap({User? user}) {
  var _user = user!;
  return {
    "displayName": _user.displayName ?? '',
    "emails": _user.email == null
        ? []
        : [
            {
              'email': _user.email,
              'type': 'primary',
            }
          ],
    "emailVerified": _user.emailVerified,
    "isAnonymous": _user.isAnonymous,
    "creationTime": _user.metadata.creationTime,
    "lastSignInTime": _user.metadata.lastSignInTime,
    "phoneNumbers": _user.phoneNumber == null
        ? []
        : [
            {
              'phoneNumber': _user.phoneNumber,
              'type': 'primary',
            }
          ],
    "photoURL": _user.photoURL ?? '',
    "uid": _user.uid,
    "bio": '',
  };
}
