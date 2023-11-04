import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/feature/login_view/model/login.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
//   final FirebaseAuth _auth;
//  LoginController(this._auth);

  final FirebaseAuth _ath = FirebaseAuth.instance;

  var email = '';
  void userIdFun(String id) {
    email = id;
    log(email.toString());
    notifyListeners();
  }

  Future<String> googleSignin(BuildContext context) async {
    const CircularProgressIndicator();
    notifyListeners();
    try {
      final isLoged = await GoogleSignIn().isSignedIn();
      if (isLoged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        return Future.value('while error occured');
      }
      final cred = await result.authentication;
      final userProfile = await _ath.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: cred.accessToken,
          idToken: cred.idToken,
        ),
      );
      final userDetail = userProfile.user;

      if (userProfile.additionalUserInfo!.isNewUser == true) {
        final userData = UserModel(
          name: userDetail!.displayName.toString(),
          email: userDetail.email.toString(),
          profile: userDetail.photoURL.toString(),
          verified: userDetail.emailVerified,
          id: userDetail.uid,
        );
        FirebaseFirestore.instance
            .collection('userProfile')
            .doc(userDetail.email)
            .set(
              userData.toSnapshot(),
            );
        userIdFun(userData.email);
        log(userData.toString());
      }
      await saveUserData();
      Routes.pushReplace(screen: '/bottomNavView');

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      return Future.value(ex.message);
    }
  }

  saveUserData() async {
    final obj = await SharedPreferences.getInstance();
    obj.setBool('userLoged', true);
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}