import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: 
        Text("History View",style: K2DFonts.bold(),),
      ),
    );
  }
}