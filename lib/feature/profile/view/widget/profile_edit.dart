import 'dart:io';

import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/feature/profile/view_model/profile_provider.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeData = context.watch<ProfileProvider>();

    // if () {

    // }

    return Scaffold(
      backgroundColor: Apc.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Routes.back();
            },
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: Apc.white,
            )),
        elevation: 0,
        backgroundColor: Apc.primary,
        title: Text(
          "Edit Profile Details",
          style: K2DFonts.bold(color: Apc.white),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Routes.back();
          return true;
        },
        child: Form(
          key: homeData.profileEditing,
          child: Column(
            children: [
              heightMedium,
              CustomTextField(
                controller: homeData.nameField,
                validate: (val) => homeData.validateName(val),
                title: 'Name',
                textInputType: TextInputType.name,
              ),
              CustomTextField(
                validate: (val) => homeData.validateEmail(val),
                controller: homeData.emailField,
                title: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextField(
                validate: (val) => homeData.onPlace(val),
                controller: homeData.city,
                title: 'City',
                textInputType: TextInputType.number,
              ),
              CustomTextField(
                validate: (val) => homeData.onPinCodeValidate(val),
                controller: homeData.pincode,
                title: 'Pin',
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeController>(
          builder: (context, homePro, _) => PlatformButton(
              text: const Text("Update"),
              color: Apc.primary,
              width: Responsive.widthMultiplier! * 83,
              height: Responsive.heightMultiplier! * 5,
              onPressed: () async {}),
        ),
      ),
    );
  }
}
