import 'package:firebase_todo/core/color/color.dart';
import 'package:flutter/material.dart';

class CustomOrWidget extends StatelessWidget {
  const CustomOrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            color: Apc.grey,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("OR"),
          ),
          Expanded(
              child: Divider(
            color: Apc.grey,
          )),
        ],
      ),
    );
  }
}
