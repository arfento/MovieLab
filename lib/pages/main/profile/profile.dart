import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/models/hive/models/user.dart';
import 'package:movie_lab/pages/main/main_controller.dart';
import 'package:movie_lab/pages/main/profile/profile_controller.dart';
import 'package:movie_lab/pages/main/profile/user_profile/lists.dart';
import 'package:movie_lab/pages/main/profile/user_profile/settings.dart';
import 'package:movie_lab/pages/main/profile/user_profile/socials.dart';
import 'package:movie_lab/pages/main/profile/user_profile/user_profile.dart';
import 'package:movie_lab/widgets/inefficacious_refresh_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return ValueListenableBuilder(
          valueListenable: Hive.box<HiveUser>("user").listenable(),
          builder: (context, userValue, child) {
            final user = userValue.values.toList().cast<HiveUser>();
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _buildBody(context,
                  user[0].name != "" && user[0].username != "" ? true : false),
            );
          },
        );
      },
    );
  }

  _buildBody(BuildContext context, bool profile) {
    switch (profile) {
      case false:
        return editUserProfileBody(context, isEdit: false);
      default:
        return GetBuilder<MainController>(
          builder: (mainController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kSecondaryColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: InefficaciousRefreshIndicator(
                  child: ListView(
                    controller: mainController.profileScrollController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 25),
                      ProfilePageUserProfile(),
                      const SizedBox(height: 40),
                      const ProfilePageLists(),
                      const SizedBox(height: 40),
                      const ProfilePageSettings(),
                      const SizedBox(height: 40),
                      const ProfilePageSocials(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        );
    }
  }

  editUserProfileBody(BuildContext context, {required bool isEdit}) {}
}
