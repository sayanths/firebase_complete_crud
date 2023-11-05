import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_container/custom_container.dart';
import 'package:firebase_todo/core/custom_size/custom_size.dart';
import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:firebase_todo/feature/home/view/widget/overview.dart';
import 'package:firebase_todo/feature/home/view/widget/view_all.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/responsive/responsive.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    CustomContainer(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Responsive.heightMultiplier! * 2,
                          ),
                          Consumer<HomeController>(
                            builder: (context, value, _) => Row(
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
                                      "${value.name} !!",
                                      style: K2DFonts.bold(fontSize: 18),
                                    )
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                        imageUrl: value.photo ?? ""),
                                  ),
                                )
                              ],
                            ),
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
                        maxHeight: Responsive.heightMultiplier! * 8,
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
                    SizedBox(
                      height: Responsive.heightMultiplier! * 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Todo Details",
                          style: K2DFonts.bold(fontSize: 22, color: Apc.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Routes.pushNonNamed(screen: const ViewALL());
                          },
                          child: Text(
                            "View All",
                            style:
                                K2DFonts.medium(fontSize: 15, color: Apc.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<HomeController>(
                      builder: (context, value, _) => value.totList.isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Responsive.heightMultiplier! * 15,
                                  ),
                                  Text(
                                    "No Data found",
                                    style: K2DFonts.regular(),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.widthMultiplier! * 1),
                              itemCount: value.totList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = value.totList.reversed
                                    .toSet()
                                    .toList()[index];
                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Delete ? ",
                                            style: K2DFonts.bold(fontSize: 18),
                                          ),
                                          content: Text(
                                            "Do you want to delete ? ",
                                            style:
                                                K2DFonts.medium(fontSize: 15),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  color: const Color.fromARGB(
                                                      255, 0, 81, 5),
                                                  child: Text(
                                                    "Delete",
                                                    style: K2DFonts.medium(
                                                        color: Apc.white),
                                                  ),
                                                  onPressed: () async {
                                                    value.delete(
                                                        data.id ?? "", context);
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                MaterialButton(
                                                  color: Apc.red,
                                                  child: Text(
                                                    "Cancel",
                                                    style: K2DFonts.medium(
                                                        color: Apc.white),
                                                  ),
                                                  onPressed: () {
                                                    Routes.back();
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Routes.pushNonNamed(
                                        screen: OverView(data: data));
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
                    )
                  ],
                ),
              ),
            )
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
            style: K2DFonts.bold(),
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
