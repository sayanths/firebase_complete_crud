import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/feature/login_view/view_model/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_todo/feature/splash_view/view_model/splash_controller.dart';

import '../feature/bottom_nav/controller/bottom_controller.dart';

class ProviderApp extends StatelessWidget {
  final Widget child;
  const ProviderApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomBottomNavController(),
        ),
         ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
      ],
      child: child,
    );
  }
}
