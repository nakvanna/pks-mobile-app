class UserData {
  UserData({
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.isAnonymous,
    required this.creationTime,
    required this.lastSignInTime,
    required this.phoneNumber,
    required this.photoURL,
    required this.uid,
    required this.bio,
  });
  final String displayName;
  final String email;
  final bool emailVerified;
  final bool isAnonymous;
  final DateTime creationTime;
  final DateTime lastSignInTime;
  final String phoneNumber;
  final String photoURL;
  final String uid;
  final String bio;

  UserData.fromJson(Map<String, Object?> json)
      : this(
          displayName: json['displayName']! as String,
          email: json['email']! as String,
          emailVerified: json['emailVerified']! as bool,
          creationTime: json['creationTime']! as DateTime,
          isAnonymous: json['isAnonymous']! as bool,
          lastSignInTime: json['lastSignInTime']! as DateTime,
          phoneNumber: json['phoneNumber']! as String,
          photoURL: json['photoURL']! as String,
          uid: json['uid']! as String,
          bio: json['bio']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      "displayName": displayName,
      "email": email,
      "emailVerified": emailVerified,
      "isAnonymous": isAnonymous,
      "creationTime": creationTime,
      "lastSignInTime": lastSignInTime,
      "phoneNumber": phoneNumber,
      "photoURL": photoURL,
      "uid": uid,
      "bio": bio,
    };
  }
}
