import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  UserData({
    required this.displayName,
    required this.emails,
    required this.emailVerified,
    required this.isAnonymous,
    required this.creationTime,
    required this.lastSignInTime,
    required this.phoneNumbers,
    required this.photoURL,
    required this.uid,
    required this.bio,
  });
  String? displayName; //This field allow to update
  List? emails; //This field allow to update
  final bool? emailVerified;
  final bool? isAnonymous;
  final Timestamp? creationTime;
  final Timestamp? lastSignInTime;
  List? phoneNumbers; //This field allow to update
  String? photoURL;
  final String? uid;
  String? bio; //This field allow to update

  UserData.fromJson(Map<String, Object?> json)
      : this(
          displayName: json['displayName']! as String,
          emails: json['emails']! as List,
          emailVerified: json['emailVerified']! as bool,
          creationTime: json['creationTime']! as Timestamp,
          isAnonymous: json['isAnonymous']! as bool,
          lastSignInTime: json['lastSignInTime']! as Timestamp,
          phoneNumbers: json['phoneNumbers']! as List,
          photoURL: json['photoURL']! as String,
          uid: json['uid']! as String,
          bio: json['bio']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      "displayName": displayName,
      "emails": emails,
      "emailVerified": emailVerified,
      "isAnonymous": isAnonymous,
      "creationTime": creationTime,
      "lastSignInTime": lastSignInTime,
      "phoneNumbers": phoneNumbers,
      "photoURL": photoURL,
      "uid": uid,
      "bio": bio,
    };
  }
}
