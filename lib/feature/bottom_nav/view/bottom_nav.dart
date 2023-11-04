import 'package:firebase_todo/feature/bottom_nav/view/widget/model.dart';
import 'package:firebase_todo/feature/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../../core/color/color.dart';
import '../../../routes/routes.dart';
import '../../profile/view/profile_view.dart';
import '../controller/bottom_controller.dart';
import 'widget/mainbottom.dart';

class BottomNavigationCustom extends StatelessWidget {
  const BottomNavigationCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomBottomNavController>(
      builder: (context, bottomNavValue, _) => Scaffold(
        extendBody: true,
        bottomNavigationBar: PandaBar(
          backgroundColor: Apc.primary,
          buttonSelectedColor: Apc.yellow,
          buttonColor: Apc.white,
          buttonData: [
            PandaBarButtonData(
              id: 'Blue',
              icon: IconlyBold.home,
              title: 'Home',
            ),
            // PandaBarButtonData(
            //     id: 'Green', icon: IconlyBold.chat, title: 'Chat'),
            // PandaBarButtonData(
            //     id: 'Red', icon: IconlyBold.heart, title: 'Favourite'),
            PandaBarButtonData(
                id: 'Yellow', icon: IconlyBold.profile, title: 'Profile'),
          ],
          onChange: (id) {
            bottomNavValue.onChanged(id);
          },
          onFabButtonPressed: () {
            Routes.push(screen: '/sellingAddWidget');
          },
        ),
        body: Builder(
          builder: (context) {
            switch (bottomNavValue.page) {
              // case 'Green':
              //   return const ChatView();
              case 'Blue':
                return const HomeView();
              // case 'Red':
              //   return const FavouriteView();
              case 'Yellow':
                return const ProfileView();
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
