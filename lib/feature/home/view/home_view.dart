import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_container/custom_container.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apc.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: CustomContainer(
              decoration: const BoxDecoration(
                  color: Apc.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              height: 150,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightMedium,
                    CustomContainer(
                      height: 70,
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: K2DFonts.regular(),
                                  ),
                                  heightVerySmall,
                                  Consumer<HomeController>(
                                    builder: (context, value, _) {
                                      return Text(
                                        "${value.name} !!",
                                        style: K2DFonts.bold(fontSize: 25),
                                      );
                                    },
                                  )
                                ],
                              ),
                              const CircleAvatar(
                                radius: 25,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(),
                    ),
                    heightVerySmall,
                    Consumer<HomeController>(
                      builder: (context, homePro, _) => LimitedBox(
                        maxHeight: Responsive.heightMultiplier! * 10,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: homePro.categoryList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CustomBox(
                              image: homePro.categoryList[index],
                              title: '',
                            );
                          },
                        ),
                      ),
                    ),
                    heightVerySmall,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(),
                    ),
                    heightSmall,
                    heightSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Todo Details",
                          style: K2DFonts.bold(fontSize: 22, color: Apc.black),
                        ),
                        Text(
                          "View All",
                          style: K2DFonts.medium(fontSize: 15, color: Apc.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
                child: CustomContainer(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Card(
                child: CustomContainer(
                    decoration:
                        BoxDecoration(border: Border.all(color: Apc.grey)),
                    height: Responsive.heightMultiplier! * 11,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const ListTile(
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
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String name;
  final String subTitle;
  const TextWidget({
    super.key,
    required this.name,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            name,
            style: K2DFonts.medium(),
          ),
        ),
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            subTitle,
            style: K2DFonts.regular(),
          ),
        ),
      ],
    );
  }
}

class CustomBox extends StatelessWidget {
  final String image;
  final String title;
  const CustomBox({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: EdgeInsets.symmetric(horizontal: Responsive.widthMultiplier! * 2),
      height: Responsive.heightMultiplier! * 8,
      width: Responsive.widthMultiplier! * 18,
      decoration: BoxDecoration(
          color: Apc.blueColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Apc.blueColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
                color: Apc.blueColor.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(5, 5))
          ]),
      child: Center(
          child: Image.asset(
        image,
        height: 35,
      )),
    );
  }
}
