import 'package:flutter/material.dart';

class CustomBottomNavController extends ChangeNotifier {
  String page = 'Blue';

  onChanged(String id) {
    page = id;
    notifyListeners();
  }
}
