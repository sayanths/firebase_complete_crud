import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_todo/routes/routes.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    Timer(const Duration(seconds: 3), () {
      Routes.push(screen: "/loginView");
    });
  }
}
