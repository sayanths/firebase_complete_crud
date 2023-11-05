import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileProvider extends ChangeNotifier {
  final profileEditing = GlobalKey<FormState>();
  final TextEditingController _nameField = TextEditingController();
  TextEditingController get nameField => _nameField;
  final TextEditingController _emailField = TextEditingController();
  TextEditingController get emailField => _emailField;
  final TextEditingController _city = TextEditingController();
  TextEditingController get city => _city;
  final TextEditingController _pincode = TextEditingController();
  TextEditingController get pincode => _pincode;
  final TextEditingController _instaLink = TextEditingController();
  TextEditingController get instaLink => _instaLink;
  final TextEditingController _faceBookLink = TextEditingController();
  TextEditingController get faceBookLink => _faceBookLink;

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

   onPinCodeValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter pin code';
    } else if (value.length != 6) {
      return 'valid pin code';
    } else if (value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return 'Special characters are not allowed';
    } else {
      return null;
    }
  }

  bool isLink(String? input) {
    if (input == null) {
      return true;
    } else {
      RegExp urlRegex = RegExp(
        r'^((http(s)?)?:\/\/)?(www\.)?[a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$',
        caseSensitive: false,
        multiLine: false,
      );

      return urlRegex.hasMatch(input);
    }
  }



  onPlace(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your city';
    } else if (value.length < 3) {
      return 'Enter a valid city';
    } else if (value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return 'Special characters are not allowed';
    } else if (int.tryParse(value) != null) {
      return 'Number values are not allowed';
    } else {
      return null;
    }
  }
}
