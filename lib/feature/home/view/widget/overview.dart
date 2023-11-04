import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/model/detail_model.dart';
import 'package:firebase_todo/feature/home/view/widget/add_userdetails.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_view.dart';

class OverView extends StatelessWidget {
  final DetailModel data;
  const OverView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          data.name ?? "",
          style: K2DFonts.bold(fontSize: 18),
        ),
        backgroundColor: Apc.primary,
        actions: [
          Consumer<HomeController>(
            builder: (context, value, _) => IconButton(
                onPressed: () {
                  Routes.pushNonNamed(
                      screen: AddUserDetails(mode: AddEditMode.edit));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Apc.white,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            heightSmall,
            TextWidget(
              name: 'Name : ',
              subTitle: data.name ?? "",
            ),
            heightSmall,
            TextWidget(
              name: 'Age : ',
              subTitle: data.age.toString(),
            ),
            heightSmall,
            TextWidget(
              name: 'Number : ',
              subTitle: data.number.toString(),
            ),
            heightSmall,
            TextWidget(
              name: 'Number : ',
              subTitle: data.email.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
