import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_lab/pages/main/profile/profile_controller.dart';
import 'package:movie_lab/pages/splash/get_user_data.dart';

class ProfilePageEditUserProfile extends StatelessWidget {
  const ProfilePageEditUserProfile({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    Get.find<ProfileController>()
        .updateTextFields(nameErrorText: "", usernameErrorText: "");
    getUserInformation();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: editUserProfileBody(context, isEdit: true));
  }

  editUserProfileBody(BuildContext context, {required bool isEdit}) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {},
    );
  }
}
