import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserDetails extends StatelessWidget {
  const AddUserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.read<HomeController>();
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
      body: Form(
        key: data.todoAdding,
        child: Column(
          children: [
            heightMedium,
            CustomTextField(
              controller: data.nameField,
              validate: (val) => data.validateName(val),
              title: 'Name',
              textInputType: TextInputType.name,
            ),
            CustomTextField(
              validate: (val) => data.validateEmail(val),
              controller: data.emailField,
              title: 'Email',
              textInputType: TextInputType.emailAddress,
            ),
            CustomTextField(
              validate: (val) => data.validateAge(val),
              controller: data.ageField,
              title: 'Age',
              textInputType: TextInputType.number,
            ),
            CustomTextField(
              validate: (val) => data.validatePhoneNumber(val),
              controller: data.numnerField,
              title: 'Number',
              textInputType: TextInputType.phone,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlatformButton(
          text: Text(
            'Submit',
            style: K2DFonts.bold(fontSize: 18),
          ),
          color: Apc.primary,
          width: Responsive.widthMultiplier! * 83,
          height: Responsive.heightMultiplier! * 5,
          onPressed: () {
            if (data.todoAdding.currentState!.validate()) {
              print("object");
            }
          },
        ),
      ),
    );
  }
}
