import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/feature/bottom_nav/view/bottom_nav.dart';
import 'package:firebase_todo/feature/login_view/model/login.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _ath = FirebaseAuth.instance;

  var email = '';
  void userIdFun(String id) {
    email = id;
    log(email.toString());
    notifyListeners();
  }

  bool googleAuthLoading = false;
  Future<String> googleSignin(BuildContext context) async {
    googleAuthLoading = true;
    notifyListeners();
    try {
      googleAuthLoading = false;
      notifyListeners();
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
      FlutterSecureStorage prefs = const FlutterSecureStorage();
      final userDetail = userProfile.user;
      if (userProfile.additionalUserInfo!.isNewUser == true) {
        final userData = UserModel(
          name: userDetail!.displayName.toString(),
          email: userDetail.email.toString(),
          profile: userDetail.photoURL.toString(),
          verified: userDetail.emailVerified,
          id: userDetail.uid,
        );
        await FirebaseFirestore.instance
            .collection('userProfile')
            .doc(userData.email)
            .set(
              userData.toSnapshot(),
            );

        userIdFun(userData.email);

        log(userData.toString());
      }
      await prefs.write(key: 'googleauth', value: true.toString());
      await prefs.write(key: 'name', value: userDetail?.displayName ?? "");
      await prefs.write(key: 'photo', value: userDetail?.photoURL ?? "");
      await prefs.write(key: 'email', value: userDetail?.email ?? "");
      Routes.pushReplaceNonNamed(screen: const BottomNavigationCustom());
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      googleAuthLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
}
