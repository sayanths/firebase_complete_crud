import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String? profile;
  final bool verified;
  final String id;
  final String? city;
  final int? pin;
  final String? fblink;
  final String? instaLink;

  UserModel({
    required this.name,
    required this.email,
    this.profile,
    required this.verified,
    required this.id,
    this.city,
    this.pin,
    this.fblink,
    this.instaLink,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    return UserModel(
      email: snap['email'],
      name: snap['name'],
      verified: snap['verified'],
      profile: snap['profile'],
      id: snap['uid'],
      city: snap['city'],
      fblink: snap['fblink'],
      instaLink: snap['instaLink'],
      pin: snap['pin'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      "name": name,
      "email": email,
      "profile": profile,
      "verified": verified,
      "uid": id,
      "city": city,
      "fblink": fblink,
      "pin": pin,
      "instaLink": instaLink
    };
  }
}
