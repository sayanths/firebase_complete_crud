import 'dart:async';

import 'package:firebase_todo/feature/bottom_nav/view/bottom_nav.dart';
import 'package:firebase_todo/feature/login_view/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    Timer(const Duration(seconds: 3), () async {
      FlutterSecureStorage prefs = const FlutterSecureStorage();
      final data = await prefs.read(key: 'googleauth');
      if (data == null) {
        Routes.pushReplaceNonNamed(screen: const LoginView());
      } else {
        Routes.pushReplaceNonNamed(screen: const BottomNavigationCustom());
      }
    });
  }
}
