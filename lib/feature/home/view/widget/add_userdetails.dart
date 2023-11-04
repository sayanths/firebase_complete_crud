import 'dart:developer';
import 'dart:io';

import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserDetails extends StatelessWidget {
  final AddEditMode mode;
  const AddUserDetails({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final data = context.watch<HomeController>();
    log(data.totList[0].id.toString());
    if (mode == AddEditMode.edit) {
      data.ageField.text = data.totList[0].age.toString();
      data.nameField.text = data.totList[0].name.toString();
      data.id = data.totList[0].id.toString();
      data.numnerField.text = data.totList[0].number.toString();
      data.emailField.text = data.totList[0].email.toString();
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
          mode == AddEditMode.add ? "Add Details" : "Edit Details",
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeController>(
          builder: (context, homePro, _) => PlatformButton(
              text: mode == AddEditMode.add && homePro.isDataAdding == true
                  ? const CircularProgressIndicator()
                  : mode == AddEditMode.edit && homePro.editingData == true
                      ? const CircularProgressIndicator()
                      //  ? const CircularProgressIndicator()
                      : Text(
                          mode == AddEditMode.add ? 'Submit' : 'Edit',
                          style: K2DFonts.bold(fontSize: 18),
                        ),
              color: Apc.primary,
              width: Responsive.widthMultiplier! * 83,
              height: Responsive.heightMultiplier! * 5,
              onPressed: () async {
                if (data.todoAdding.currentState!.validate()) {
                  if (mode == AddEditMode.add) {
                    await homePro
                        .addToCollection(context, AddEditMode.add)
                        .whenComplete(() async {
                      await homePro.todoListFun();
                    });
                  } else if (mode == AddEditMode.edit) {
                    await homePro
                        .addToCollection(context, AddEditMode.edit)
                        .whenComplete(() async {
                      await homePro.todoListFun();
                    });
                  }
                }
              }),
        ),
      ),
    );
  }
}
