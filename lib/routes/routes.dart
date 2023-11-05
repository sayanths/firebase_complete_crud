import 'package:firebase_todo/feature/home/model/detail_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_todo/feature/login_view/view/login_view.dart';

import '../feature/bottom_nav/view/bottom_nav.dart';

class Routes {
  static final routeKey = GlobalKey<NavigatorState>();

  Map<String, Widget Function(BuildContext)> route = {
    "/loginView": (context) => const LoginView(),
    "/BottomNavigationCustom": (context) => const BottomNavigationCustom()
  };

  static push({
    required var screen,
  }) {
    routeKey.currentState?.pushNamed(screen);
  }

  static pushNamed({
    required String screen,
    String? arguments,
  }) {
    routeKey.currentState?.pushNamed(screen, arguments: arguments);
  }

  static pushNonNamed({required var screen}) {
    routeKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static back({bool? value}) {
    routeKey.currentState?.pop();
  }

  static pushReplace({required var screen}) {
    routeKey.currentState?.pushReplacementNamed(screen);
  }

  static pushRemoveUntil({required var screen}) {
    routeKey.currentState?.pushNamedAndRemoveUntil(
      screen,
      (route) => false,
    );
  }

  static sizedAnimationPush({required var screen}) {
    routeKey.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation =
              CurvedAnimation(curve: Curves.bounceIn, parent: animation);
          return Align(
            child: Align(
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }

  static pushReplaceNonNamed({required var screen}) {
    routeKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static pushRemoveUntilNonNamed(Widget screen) {
    routeKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false, // Remove all previous routes from the stack
    );
  }
}
