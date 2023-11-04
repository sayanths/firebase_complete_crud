import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  String? name;
  String? photo;
  String? email;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> fetchUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      name = user.displayName;
      photo = user.photoURL;
      email = user.email;
      notifyListeners();
    }
    notifyListeners();
  }
}
