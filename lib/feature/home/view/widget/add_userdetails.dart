import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';

class AddUserDetails extends StatelessWidget {
  const AddUserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apc.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Apc.primary,
        title: Text(
          "Add Details",
          style: K2DFonts.bold(color: Apc.white),
        ),
      ),
      body: Column(
        children: [
          heightMedium,
          const CustomTextField(
            title: 'Name',
            textInputType: TextInputType.name,
          ),
          const CustomTextField(
            title: 'Email',
            textInputType: TextInputType.emailAddress,
          ),
          const CustomTextField(
            title: 'Age',
            textInputType: TextInputType.number,
          ),
          const CustomTextField(
            title: 'Number',
            textInputType: TextInputType.phone,
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlatformButton(
          text: 'Submit',
          color: Apc.primary,
          width: Responsive.widthMultiplier! * 83,
          height: Responsive.heightMultiplier! * 5,
          onPressed: () {
            Routes.back();
          },
        ),
      ),
    );
  }
}
