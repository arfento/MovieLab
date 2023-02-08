import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/pages/main/home/home_page.dart';
import 'package:movie_lab/pages/main/main_controller.dart';
import 'package:movie_lab/pages/main/profile/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = <Widget>[
    HomePage(),
    SearchPage(),
    UserListsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          body: pages.elementAt(controller.selectedIndex),
          bottomNavigationBar: FlashyTabBar(
              selectedIndex: controller.selectedIndex,
              animationCurve: Curves.linear,
              showElevation: true,
              backgroundColor: kBackgroundColor,
              animationDuration: Duration(milliseconds: 250),
              iconSize: 27.5,
              height: 70,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.75),
                  blurRadius: 7.5,
                  offset: const Offset(0, 0),
                ),
              ],
              onItemSelected: (value) => controller.changeIndex(value),
              items: [
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.home_max_rounded,
                  ),
                  activeColor: Colors.white,
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                  activeColor: Colors.white,
                  title: const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.bookmark_outline_rounded,
                  ),
                  activeColor: Colors.white,
                  title: const Text(
                    'Lists',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.podcasts_rounded,
                  ),
                  activeColor: Colors.white,
                  inactiveColor: const Color(0xff9496c1),
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ]),
        );
      },
    );
  }
}
