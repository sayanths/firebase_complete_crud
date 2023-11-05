import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/core/color/color.dart';
import 'package:firebase_todo/core/custom_container/custom_container.dart';
import 'package:firebase_todo/core/custom_textfield/custom_textfield.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:firebase_todo/feature/login_view/view/login_view.dart';
import 'package:firebase_todo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../responsive/responsive.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, _) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: Responsive.heightMultiplier! * 35,
                    width: double.infinity,
                    color: Apc.primary,
                  ),
                  Positioned(
                    bottom: -60,
                    left: 15,
                    child: Consumer<HomeController>(
                      builder: (context, value, _) => CustomContainer(
                        height: Responsive.heightMultiplier! * 20,
                        width: Responsive.widthMultiplier! * 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Apc.white),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                value.photo ?? "",
                              ),
                              fit: BoxFit.cover),
                          color: Apc.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 25,
                    right: Responsive.textMultiplier! * 5,
                    bottom: Responsive.textMultiplier! * 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                value.name.toString(),
                                style: const TextStyle(
                                    color: Apc.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                value.email.toString(),
                                style: const TextStyle(
                                    color: Apc.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: Responsive.textMultiplier! * 1,
                  //   bottom: Responsive.textMultiplier! * 2.5,
                  //   child: Text(
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     value.email.toString(),
                  //     style: const TextStyle(color: Apc.white, fontSize: 10),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.heightMultiplier! * 5,
                      horizontal: Responsive.widthMultiplier! * 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Positioned(
                          left: Responsive.textMultiplier! * 2.5,
                          top: Responsive.textMultiplier! * 5,
                          child: const Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "Profile",
                            style: TextStyle(
                                color: Apc.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Logout"),
                                  content: const Text(
                                      "Are you sure want to logout?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: const Text("Yes"),
                                          onPressed: () async {
                                            FlutterSecureStorage prefs =
                                                const FlutterSecureStorage();
                                            await FirebaseAuth.instance
                                                .signOut();
                                            await prefs.deleteAll();
                                            Routes.pushRemoveUntilNonNamed(
                                                const LoginView());
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("No"),
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
                          icon: const Icon(
                            IconlyLight.logout,
                            color: Apc.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    right: 25,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Add Mobile number"),
                                  content: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: inputDecoration(
                                        hintText:
                                            'Enter your complaint here..'),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: const Text("Submit"),
                                          onPressed: () {},
                                        ),
                                        TextButton(
                                          child: const Text("No"),
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
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        const Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "Edit Profile",
                          style: TextStyle(
                              color: Color.fromARGB(255, 73, 72, 72),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.heightMultiplier! * 9,
              ),
              ProfilePageListTile(
                icon: IconlyBold.activity,
                title: "My Posts",
                function: () {
                  Routes.push(screen: '/myPosts');
                },
              ),
              ProfilePageListTile(
                icon: IconlyBold.paper,
                title: "Complaint Box",
                function: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Complaint Box"),
                        content: TextField(
                          maxLength: 500,
                          maxLines: 5,
                          decoration: inputDecoration(
                              hintText: 'Enter your complaint here..'),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: const Text("Yes"),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text("No"),
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
              ),
              ProfilePageListTile(
                icon: IconlyBold.document,
                title: "Suggestions",
                function: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Suggestion Box"),
                        content: TextField(
                          maxLength: 500,
                          maxLines: 5,
                          decoration: inputDecoration(
                              hintText:
                                  'Eg:-I want some more categories also etc.'),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: const Text("Yes"),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text("No"),
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
              ),
              ProfilePageListTile(
                icon: IconlyBold.discovery,
                title: "About Us",
                function: () {},
              ),
              ProfilePageListTile(
                icon: IconlyBold.paper,
                title: "Terms and Coniditon",
                function: () {},
              ),
              ProfilePageListTile(
                icon: Icons.pages,
                title: "Privacy policy",
                function: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePageListTile extends StatelessWidget {
  final Function()? function;
  final String title;
  final IconData icon;
  const ProfilePageListTile({
    super.key,
    this.function,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      leading: Icon(
        icon,
        color: Apc.black,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
