import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/models/item_models/show_models/show_preview_model.dart';
import 'package:movie_lab/modules/preferences/preferences_shareholder.dart';
import 'package:movie_lab/modules/tools/navigate.dart';
import 'package:movie_lab/pages/main/profile/profile_controller.dart';
import 'package:movie_lab/pages/main/profile/user_profile/edit_user_profile.dart';
import 'package:movie_lab/pages/main/profile/user_profile/sections/dividers.dart';
import 'package:movie_lab/pages/main/profile/user_profile/sections/imdb_rating.dart';
import 'package:movie_lab/pages/main/profile/user_profile/sections/stats_box.dart';
import 'package:movie_lab/pages/main/profile/user_profile/sections/user_profile_image.dart';
import 'package:movie_lab/pages/main/profile/user_stats/user_stats.dart';

class ProfilePageUserProfile extends StatelessWidget {
  ProfilePageUserProfile({super.key});
  late List<ShowPreview> items;

  @override
  Widget build(BuildContext context) {
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    items = getAllItems(allLists: preferencesShareholder.getAllLists());

    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Center(
          child: Stack(
            children: [
              Container(
                height: 530,
                margin: EdgeInsets.only(top: 64),
                padding: EdgeInsets.only(top: 70),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      profileController.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      profileController.username,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserStatsBox(
                                value: profileController.watchedMoviesCount
                                    .toString(),
                                title: "Watched\nMovies",
                                items: const [],
                              ),
                              UserStatsBox(
                                value: profileController.watchedSeriesCount
                                    .toString(),
                                title: "Watched\nSeries",
                                items: const [],
                              ),
                            ],
                          ),
                        ),
                        UserIMDbRating(
                            imdbRatingAverage:
                                profileController.imdbRatingAverage),
                      ],
                    ),
                    bigDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserStatsBox(
                            title: "Favorite\nGenre",
                            items: [
                              for (ShowPreview show in items) show.genres!
                            ],
                            sizeType: 2),
                        smallDivider(),
                        UserStatsBox(
                            title: "Favorite\nCompany",
                            items: [
                              for (ShowPreview show in items) show.companies!
                            ],
                            sizeType: 2),
                        smallDivider(),
                        UserStatsBox(
                            title: "Favorite\nCountry",
                            items: [
                              for (ShowPreview show in items) show.countries!
                            ],
                            sizeType: 2),
                      ],
                    ),
                    const SizedBox(
                      height: 2.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 35,
                        ),
                        UserStatsBox(
                            title: "Favorite\nLanguage",
                            items: [
                              for (ShowPreview show in items) show.languages!
                            ],
                            sizeType: 2),
                        smallDivider(),
                        UserStatsBox(
                            title: "Favorite\nContent-Rating",
                            items: [
                              for (ShowPreview show in items)
                                show.contentRating!
                            ],
                            width: MediaQuery.of(context).size.width * 0.325,
                            sizeType: 2),
                      ],
                    ),
                    bigDivider(),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.5))),
                        onPressed: () {
                          Navigate.pushTo(context, const UserStats());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.75),
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'See ', style: TextStyle()),
                                TextSpan(
                                    text: profileController.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white.withOpacity(0.9))),
                                const TextSpan(
                                    text: '\'s stats', style: TextStyle()),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              userProfileImage(context, icon: Icons.edit, onTap: () {
                Navigate.pushHeroicTo(
                    context, const ProfilePageEditUserProfile());
              }),
            ],
          ),
        );
      },
    );
  }
}

List<ShowPreview> getAllItems({required List<List<ShowPreview>> allLists}) {
  List<ShowPreview> items = [];
  for (List<ShowPreview> list in allLists) {
    items.addAll(list);
  }
  return items;
}
