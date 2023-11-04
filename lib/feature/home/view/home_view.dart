import 'package:cached_network_image/cached_network_image.dart';
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
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: const SizedBox(),
      //   backgroundColor: Apc.white,
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       child: CircleAvatar(),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            heightSmall,
            heightVerySmall,
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomContainer(
                height: 50,
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
                            Text(
                              "Sayanth A !!",
                              style: K2DFonts.bold(fontSize: 25),
                            ),
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
            )),
            Expanded(
                flex: 3,
                child: CustomContainer(
                  color: Apc.white,
                  height: 50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightVerySmall,
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
                              itemCount: 3,
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
                        heightMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Todo Details",
                              style:
                                  K2DFonts.bold(fontSize: 22, color: Apc.black),
                            ),
                            Text(
                              "View All",
                              style: K2DFonts.medium(
                                  fontSize: 17, color: Apc.grey),
                            ),
                          ],
                        ),
                        heightSmall,
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 5,
                child: CustomContainer(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      heightSmall,
                      Card(
                        child: CustomContainer(
                          decoration: BoxDecoration(
                              border: Border.all(color: Apc.grey)),
                          height: Responsive.heightMultiplier! * 15,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(child: CachedNetworkImage(imageUrl: '')),
                              const Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("data"),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
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
      height: Responsive.heightMultiplier! * 10,
      width: Responsive.widthMultiplier! * 25,
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
        height: 40,
      )),
    );
  }
}
