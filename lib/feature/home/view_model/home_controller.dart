import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  String? name;
  String? photo;
  String? email;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> fetchUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      name = user.displayName;
      photo = user.photoURL;
      email = user.email;
      notifyListeners();
    }
    notifyListeners();
  }

  List<String> categoryList = [
    'assets/send.png',
    'assets/amount recive.png',
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
}
