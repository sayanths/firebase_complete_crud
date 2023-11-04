import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/feature/home/model/detail_model.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    fetchUserData();
    todoLIstFun();
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
  Future<void> todoLIstFun() async {
    totList.clear();
    QuerySnapshot<Map<String, dynamic>> snapshots =
        await FirebaseFirestore.instance.collectionGroup('userDetails').get();
    final list = snapshots.docs
        .map((docSnap) => DetailModel.fromSnapshot(docSnap))
        .toList();
    totList.addAll(list);
    notifyListeners();
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

  bool isDataAdding = false;
  Future<void> addToCollection() async {
    isDataAdding == true;
    notifyListeners();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;
    final DocumentReference userProfileRef =
        firestore.collection('userProfile').doc(user?.uid);
    final CollectionReference carsCollectionRef =
        userProfileRef.collection('userDetails');
    Map<String, dynamic> data = {
      "name": nameField.text.trim(),
      "email": emailField.text.trim().toLowerCase(),
      "age": int.tryParse(
        ageField.text,
      ),
      "number": int.tryParse(
        numnerField.text,
      ),
    };
    log(data.toString());
    await carsCollectionRef.add(data).then((value) {
      isDataAdding == false;
      notifyListeners();
      onClear();
      Routes.back();
      log("Item added to collection successfully!");
    }).catchError((error) {
      isDataAdding == false;
      notifyListeners();
      log("Failed to add item to collection: $error");
    });
    isDataAdding == false;
    notifyListeners();
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
