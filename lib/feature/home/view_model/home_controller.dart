import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/feature/bottom_nav/view/bottom_nav.dart';
import 'package:firebase_todo/feature/home/model/detail_model.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum AddEditMode {
  add,
  edit,
}

class HomeController extends ChangeNotifier {
  HomeController() {
    fetchUserData();
    todoListFun();
  }
  String? name;
  String? photo;
  String? email;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> fetchUserData() async {
    FlutterSecureStorage prefs = const FlutterSecureStorage();
    final User? user = _auth.currentUser;
    if (user != null) {
      String? names = await prefs.read(key: 'name');
      name = names ?? "Loading..";
      String? photos = await prefs.read(key: 'photo');
      photo = photos ?? "";
      String? emails = await prefs.read(key: 'email');
      email = emails ?? "loading..";
      notifyListeners();
    }
    notifyListeners();
  }

  List<DetailModel> totList = [];

  Future<void> todoListFun() async {
    totList.clear();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final QuerySnapshot<Map<String, dynamic>> snapshots =
          await FirebaseFirestore.instance
              .collection('userProfile')
              .doc(user.uid)
              .collection('userDetails')
              .get();
      final set = <DetailModel>{};
      for (var docSnap in snapshots.docs) {
        final detailModel = DetailModel.fromSnapshot(docSnap);
        set.add(detailModel);
      }
      final list = set.toList();

      totList.addAll(list);
      notifyListeners();
    } else {}
  }

  List<String> categoryList = [
    'assets/send.png',
    'assets/amount recive.png',
    'assets/recive.png',
    'assets/recive.png',
  ];

  final todoAdding = GlobalKey<FormState>();
  final TextEditingController _nameField = TextEditingController();
  TextEditingController get nameField => _nameField;
  final TextEditingController _emailField = TextEditingController();
  TextEditingController get emailField => _emailField;
  final TextEditingController _ageField = TextEditingController();
  TextEditingController get ageField => _ageField;
  final TextEditingController _numnerField = TextEditingController();
  TextEditingController get numnerField => _numnerField;
  String? id = '';
  bool isDataAdding = false;
  bool editingData = false;

  Future<void> addToCollection(BuildContext context, AddEditMode mode,
      [String? editId]) async {
    mode == AddEditMode.add ? isDataAdding = true : editingData == true;

    notifyListeners();

    final User? user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (user != null) {
      final DocumentReference userProfileRef =
          firestore.collection('userProfile').doc(user.uid);
      String customDocumentId =
          DateTime.now().microsecondsSinceEpoch.toString();

      final DocumentReference userDetails =
          userProfileRef.collection('userDetails').doc(customDocumentId);

      Map<String, dynamic> data = {
        "id": mode == AddEditMode.edit ? editId : customDocumentId,
        "name": nameField.text.trim(),
        "email": emailField.text.trim().toLowerCase(),
        "age": int.tryParse(ageField.text.trim()),
        "number": int.tryParse(numnerField.text.trim()),
      };

      if (mode == AddEditMode.add) {
        await userDetails.set(data).then((value) {
          mode == AddEditMode.add ? isDataAdding = false : editingData == false;
          notifyListeners();
          onClear();
          Routes.back();
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: 'Item added to collection successfully!',
            ),
          );
        }).catchError((error) {
          isDataAdding = false;
          notifyListeners();
          log(error.toString());
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: "$error",
            ),
          );
        });
      } else if (mode == AddEditMode.edit) {
        final CollectionReference userDetails =
            userProfileRef.collection('userDetails');
        log("message $editId");
        final DocumentReference docRef = userDetails.doc(editId);
        final docSnapshot = await docRef.get();
        if (docSnapshot.exists) {
          await docRef.update(data).then((value) async {
            log("data is $data");
            editingData == false;
            notifyListeners();

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const BottomNavigationCustom(),
            ));
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Item updated successfully!',
              ),
            );
          }).catchError((error) {
            // Handle update error
            log("error is $error");
            editingData = false;
            notifyListeners();
            log(error.toString());
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "$error",
              ),
            );
          });
        } else {
          log('Document with ID $editId does not exist.');
        }
      }
    } else {
      isDataAdding = false;
      editingData = false;
      notifyListeners();
    }
  }

  Future<void> delete(String deleteId, BuildContext context) async {
    try {
      log("message");

      final User? user = FirebaseAuth.instance.currentUser;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentReference userProfileRef =
          firestore.collection('userProfile').doc(user?.uid);

      final CollectionReference userDetails =
          userProfileRef.collection('userDetails');

      final newDocumentRef = userDetails.doc();

      id = newDocumentRef.id;

      await userDetails.doc(deleteId).delete().whenComplete(() async {
        await todoListFun();
        Routes.back();
      });
    } catch (e) {
      log("s");
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "$e",
        ),
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    final specialCharacters = RegExp(r'[!@#%^&*(),.?":{}|<>]');

    if (value.contains(specialCharacters)) {
      return 'Special characters are not allowed';
    }
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return 'Numeric values are not allowed';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your number';
    }

    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericValue.length != 10) {
      return 'Please enter a 10-digit number';
    }

    // Check if the numericValue is a repetitive sequence
    if (RegExp(
            r'^(0{10}|1{10}||2{10}|3{10}|3{10}|4{10}|5{10}|6{10}|7{10}|8{10}|9{10}|1234567890|0123456789)$')
        .hasMatch(numericValue)) {
      return 'Invalid number';
    }

    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your number';
    }

    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // ignore: prefer_is_empty
    if (numericValue.length <= 0) {
      return 'Please enter proper age';
    }
    // Check if the numericValue is a repetitive sequence
    if (RegExp(
            r'^(0{10}|1{10}||2{10}|3{10}|3{10}|4{10}|5{10}|6{10}|7{10}|8{10}|9{10}|1234567890|0123456789)$')
        .hasMatch(numericValue)) {
      return 'Invalid number';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return !regex.hasMatch(value) ? 'Enter a valid email address' : null;
  }

  void onClear() {
    nameField.clear();
    ageField.clear();
    numnerField.clear();
    emailField.clear();
  }
}
