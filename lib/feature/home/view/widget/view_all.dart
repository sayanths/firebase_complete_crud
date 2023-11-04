import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/routes.dart';
import '../home_view.dart';
import 'overview.dart';

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
        child: Consumer<HomeController>(
          builder: (context, value, _) => Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.widthMultiplier! * 1),
                itemCount: value.totList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = value.totList[index];
                  return GestureDetector(
                    onTap: () {
                      Routes.pushNonNamed(screen: OverView(data: data));
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: TextWidget(
                          name: 'Name : ',
                          subTitle: data.name ?? "",
                        ),
                        subtitle: TextWidget(
                          name: 'Age : ',
                          subTitle: data.age.toString(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
