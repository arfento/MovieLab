import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_lab/models/user_model/user_model.dart';
import 'package:movie_lab/modules/preferences/preferences_shareholder.dart';
import 'package:movie_lab/pages/main/profile/profile_controller.dart';
import 'package:movie_lab/pages/main/profile/user_profile/sections/user_profile_image.dart';
import 'package:movie_lab/pages/splash/get_user_data.dart';
import 'package:movie_lab/widgets/buttons/glassmorphism_button.dart';
import 'package:movie_lab/widgets/textfield_widget.dart';

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
      builder: (profileController) {
        return Scaffold(
          appBar: AppBar(
            leading: isEdit ? BackButton() : null,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              userProfileImage(
                context,
                icon: Icons.add_a_photo,
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    profileController.updateUSerInfo(imageUrl: image.path);
                  }
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Name',
                text: profileController.name,
                errorText: profileController.nameErrorText,
                onChanged: (name) {
                  profileController.name = name.trim();
                },
                onTap: () {
                  profileController.updateTextFields(nameErrorText: "");
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Username',
                text: profileController.username,
                errorText: profileController.usernameErrorText,
                onChanged: (username) {
                  profileController.username = username.trim();
                },
                onTap: () {
                  profileController.updateTextFields(usernameErrorText: "");
                },
              ),
              SizedBox(
                height: 40,
              ),
              GmButton(
                text: "Save",
                onTap: () {
                  PreferencesShareholder preferencesShareholder =
                      PreferencesShareholder();

                  if (profileController.name == "") {
                    profileController.updateTextFields(
                        nameErrorText: "Name field cannot be empty!");
                  }
                  if (profileController.username == "") {
                    profileController.updateTextFields(
                        usernameErrorText: "Username field cannot be empty!");
                  }
                  if (profileController.username != "" &&
                      profileController.name != "") {
                    preferencesShareholder.updateUser(
                        user: User(
                            name: profileController.name,
                            username: profileController.username,
                            imageUrl: profileController.imageUrl));
                    profileController.updateUSerInfo(
                        name: profileController.name,
                        username: profileController.username,
                        imageUrl: profileController.imageUrl);
                    if (isEdit) {
                      Navigator.pop(context);
                    }
                  }
                },
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 5),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        );
      },
    );
  }
}
