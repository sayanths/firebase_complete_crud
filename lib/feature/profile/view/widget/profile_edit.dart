import 'dart:io';

import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/profile/view_model/profile_provider.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditView extends StatelessWidget {
  final ProfileProvider data;
  const ProfileEditView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final homeData = context.watch<ProfileProvider>();
    if (homeData.profileList.isNotEmpty) {
      data.city.text = homeData.profileList[0].city ?? "";
      data.pincode.text = homeData.profileList[0].pin == null
          ? ""
          : homeData.profileList[0].pin.toString();
      data.faceBookLink.text = homeData.profileList[0].fblink ?? "";
      data.instaLink.text = homeData.profileList[0].instaLink ?? "";
    }

    return Scaffold(
      backgroundColor: Apc.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              data.onClear();
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
          data.onClear();
          Routes.back();
          return true;
        },
        child: Form(
          key: homeData.profileEditing,
          child: Column(
            children: [
              heightMedium,
              CustomTextField(
                validate: (val) => homeData.onPlace(val),
                controller: homeData.city,
                title: 'City',
                textInputType: TextInputType.name,
              ),
              CustomTextField(
                validate: (val) => homeData.onPinCodeValidate(val),
                controller: homeData.pincode,
                title: 'Pin',
                textInputType: TextInputType.number,
              ),
              CustomTextField(
                validate: (val) {
                  if (!homeData.isLink(val)) {
                    return "Please enter a valid URL";
                  }
                  return null;
                },
                controller: homeData.instaLink,
                title: 'Instagram Link',
                textInputType: TextInputType.name,
              ),
              CustomTextField(
                validate: (val) {
                  if (!homeData.isLink(val)) {
                    return "Please enter a valid URL";
                  }
                  return null;
                },
                controller: homeData.faceBookLink,
                title: 'Facebook Link',
                textInputType: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProfileProvider>(
          builder: (context, homePro, _) => PlatformButton(
              text: homePro.updateLoading == true
                  ? const CupertinoActivityIndicator(
                      color: Apc.white,
                    )
                  : const Text("Update"),
              color: Apc.primary,
              width: Responsive.widthMultiplier! * 83,
              height: Responsive.heightMultiplier! * 5,
              onPressed: () async {
                await homePro.updateProfile(
                    context, homeData.profileList[0].email.toString());
              }),
        ),
      ),
    );
  }
}
