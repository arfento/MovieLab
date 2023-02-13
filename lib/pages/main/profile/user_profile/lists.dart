import 'package:flutter/material.dart';
import 'package:movie_lab/constants/user_lists.dart';
import 'package:movie_lab/modules/tools/capitalizer.dart';
import 'package:movie_lab/modules/tools/navigate.dart';
import 'package:movie_lab/pages/main/profile/list_page/list_page.dart';
import 'package:movie_lab/widgets/buttons_section.dart';
import 'package:movie_lab/widgets/section_title.dart';

class ProfilePageLists extends StatelessWidget {
  const ProfilePageLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title: 'Lists',
          fontSize: 22.5,
          fontWeight: FontWeight.w700,
          padding: EdgeInsets.only(bottom: 12.5),
        ),
        ButtonsSection(
          height: 500,
          items: [
            for (Map<String, dynamic> list in userLists)
              ButtonSectionItem(
                title: list["name"] != "recommendations"
                    ? list["name"].toString().capitalize()
                    : "${list["name"].toString().capitalize()} for you",
                icon: list["icon"],
                iconColor: list["color"],
                iconPadding: list["padding"],
                onPressed: () {
                  Navigate.pushTo(context, ListPage(listName: list["name"]));
                },
              ),
          ],
        )
      ],
    );
  }
}
