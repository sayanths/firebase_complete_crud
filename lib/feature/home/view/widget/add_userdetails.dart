import 'dart:developer';
import 'dart:io';

import 'package:firebase_todo/core/button/custom.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/model/detail_model.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserDetails extends StatelessWidget {
  final DetailModel? data;
  final AddEditMode mode;
  const AddUserDetails({
    super.key,
    required this.mode,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final homeData = context.watch<HomeController>();

    if (mode == AddEditMode.edit) {
      log(data!.id.toString());
      homeData.ageField.text = data?.age.toString() ?? "";
      homeData.nameField.text = data?.name.toString() ?? "";
      homeData.id = data?.id.toString() ?? "";
      homeData.numnerField.text = data?.number.toString() ?? "";
      homeData.emailField.text = data?.email.toString() ?? "";
    }

    return Scaffold(
      backgroundColor: Apc.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              homeData.onClear();
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
          homeData.onClear();
          Routes.back();
          return true;
        },
        child: Form(
          key: homeData.todoAdding,
          child: SingleChildScrollView(
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
                  validate: (val) => homeData.validateAge(val),
                  controller: homeData.ageField,
                  title: 'Age',
                  textInputType: TextInputType.number,
                ),
                CustomTextField(
                  validate: (val) => homeData.validatePhoneNumber(val),
                  controller: homeData.numnerField,
                  title: 'Number',
                  textInputType: TextInputType.phone,
                )
              ],
            ),
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
                          mode == AddEditMode.add ? 'Add' : 'Update',
                          style: K2DFonts.bold(fontSize: 18),
                        ),
              color: Apc.primary,
              width: Responsive.widthMultiplier! * 83,
              height: Responsive.heightMultiplier! * 5,
              onPressed: () async {
                if (homeData.todoAdding.currentState!.validate()) {
                  if (mode == AddEditMode.add) {
                    await homePro
                        .addToCollection(context, AddEditMode.add)
                        .whenComplete(() async {
                      await homePro.todoListFun();
                    });
                  } else if (mode == AddEditMode.edit) {
                    await homePro
                        .addToCollection(
                            context, AddEditMode.edit, data?.id.toString())
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
