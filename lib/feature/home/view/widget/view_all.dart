import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:flutter/material.dart';

import '../home_view.dart';

class ViewALL extends StatelessWidget {
  const ViewALL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Apc.primary,
        elevation: 0,
        title: Text(
          "All Todo List",
          style: K2DFonts.bold(fontSize: 18, color: Apc.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.widthMultiplier! * 1),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Card(
                  elevation: 0,
                  child: ListTile(
                    title: TextWidget(
                      name: 'Name : ',
                      subTitle: 'sayatnth Athiyadath ',
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // const TextWidget(
                        //   name: 'Age : ',
                        //   subTitle: 'sayatnth Athiyadath ',
                        // ),
                        // heightVerySmall,
                        // const TextWidget(
                        //   name: 'Email : ',
                        //   subTitle: 'sayatnth Athiyadath ',
                        // ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
