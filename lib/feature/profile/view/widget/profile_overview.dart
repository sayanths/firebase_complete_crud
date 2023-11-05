import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_container/custom_container.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view/home_view.dart';
import 'package:firebase_todo/feature/profile/view/widget/profile_edit.dart';
import 'package:firebase_todo/feature/profile/view_model/profile_provider.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/custom_size/custom_size.dart';
import '../../../home/view_model/home_controller.dart';

class OverViewProfileView extends StatelessWidget {
  final ProfileProvider data;
  const OverViewProfileView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Profile",
          style: K2DFonts.bold(fontSize: 18),
        ),
        backgroundColor: Apc.primary,
        actions: [
          Consumer<HomeController>(
            builder: (context, value, _) => IconButton(
                onPressed: () {
                  Routes.pushNonNamed(screen: ProfileEditView(data: data));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Apc.white,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            heightSmall,
            Hero(
              tag: 'profile',
              child: CustomContainer(
                height: Responsive.heightMultiplier! * 20,
                width: Responsive.widthMultiplier! * 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Apc.white),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        data.photo ?? "",
                      ),
                      fit: BoxFit.cover),
                  color: Apc.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            heightSmall,
            const Divider(),
            heightSmall,
            Consumer<ProfileProvider>(
              builder: (context, profilePro, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    name: 'Name :  ',
                    subTitle: data.name ?? "",
                  ),
                  heightSmall,
                  TextWidget(
                    name: 'Email :  ',
                    subTitle: data.email ?? "",
                  ),
                  heightSmall,
                  TextWidget(
                    name: 'City : ',
                    subTitle: data.profileList[0].city == null
                        ? "No found"
                        : data.profileList[0].city ?? "",
                  ),
                  heightSmall,
                  TextWidget(
                    name: 'Pin :  ',
                    subTitle: data.profileList[0].pin == null
                        ? "No found"
                        : data.profileList[0].pin.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
