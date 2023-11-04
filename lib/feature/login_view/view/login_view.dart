import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/custom_container/custom_container.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/core/images/login_images.dart';
import 'package:firebase_todo/feature/login_view/view/widget/custom_or.dart';
import 'package:firebase_todo/feature/login_view/view_model/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/color/color.dart';
import '../../../responsive/responsive.dart';
import '../../bottom_nav/view/bottom_nav.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, value, _) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
            ])),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.heightMultiplier! * 2,
                  ),
                  SizedBox(
                    height: Responsive.heightMultiplier! * 1,
                  ),
                  Text("Be Safe with ",
                      style: K2DFonts.bold(
                          color: Apc.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textMultiplier! * 2)),
                  Text("Fin Tech",
                      style: K2DFonts.bold(
                          color: Apc.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textMultiplier! * 5)),
                  Center(
                    child: Image.asset(
                      Images.loginImages,
                      height: Responsive.heightMultiplier! * 20,
                    ),
                  ),
                  heightSmall,
                  const CustomTextField(
                      title: 'CustomerID',
                      textInputType: TextInputType.emailAddress),
                  const CustomTextField(
                      title: 'Password',
                      textInputType: TextInputType.visiblePassword),
                  const ForgotPassWidget(),
                  heightSmall,
                  heightSmall,
                  PlatformButton(
                    text: 'Login',
                    color: Apc.primary,
                    width: Responsive.widthMultiplier! * 83,
                    height: Responsive.heightMultiplier! * 5,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavigationCustom(),
                      ));
                    },
                  ),
                  heightSmall,
                  const JoinAccountWidget(),
                  heightMedium,
                  const CustomOrWidget(),
                  heightSmall,
                  heightSmall,
                  GestureDetector(
                    onTap: () async {
                      await value.googleSignin(context);
                    },
                    child: const GoogleLoginWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPassWidget extends StatelessWidget {
  const ForgotPassWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.widthMultiplier! * 5),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Fogot Password ?",
          style: K2DFonts.medium(),
        ),
      ),
    );
  }
}

class GoogleLoginWidget extends StatelessWidget {
  const GoogleLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: CustomContainer(
            height: Responsive.heightMultiplier! * 6,
            width: Responsive.widthMultiplier! * 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Apc.white)),
            child: Row(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.widthMultiplier! * 2,
                  ),
                  child: Image.asset(
                    "assets/logo google.png",
                    height: Responsive.heightMultiplier! * 3,
                  ),
                ),
                Text(
                  "Join with google",
                  style: TextStyle(
                      color: Apc.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.textMultiplier! * 2),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class JoinAccountWidget extends StatelessWidget {
  const JoinAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.widthMultiplier! * 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Dont' have an account? ",
            style: K2DFonts.medium(),
          ),
          Text(
            "Join",
            style: K2DFonts.bold(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
