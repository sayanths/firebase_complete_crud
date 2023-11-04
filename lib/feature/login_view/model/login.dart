import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String? profile;
  final bool verified;
  final String id;

  UserModel(
     {
    required this.name,
    required this.email,
    this.profile,
    required this.verified,
    required this.id
  });

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    return UserModel(
      email: snap['email'],
      name: snap['name'],
      verified: snap['verified'],
      profile: snap['profile'],
      id: snap['uid'],

    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      "name": name,
      "email": email,
      "profile": profile,
      "verified": verified,
      "uid": id,
    };
  }
}
