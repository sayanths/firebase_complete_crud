import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User not logged in, you can show a login screen or handle accordingly
      return Container();
    }

    // final userEmail = user.email;

    return const Scaffold(body: Column());
  }
}
