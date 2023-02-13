import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/models/item_models/show_models/show_preview_model.dart';
import 'package:movie_lab/modules/preferences/preferences_shareholder.dart';
import 'package:movie_lab/pages/main/profile/list_page/sections/stats_page/sections/navbar.dart';
import 'package:movie_lab/pages/main/profile/list_page/sections/stats_page/sections/stats_chart.dart';
import 'package:movie_lab/pages/main/profile/profile_controller.dart';
import 'package:movie_lab/pages/main/profile/user_profile/user_profile.dart';

class UserStats extends StatelessWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShowPreview> items = [];
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    items = getAllItems(allLists: preferencesShareholder.getAllLists());

    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Scaffold(
          appBar: listPageStatsNavbar(context,
              listName: "${profileController.name}'s"),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        profileController.imdbRatingAverage.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: kImdbColor,
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        size: 30,
                        color: kImdbColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: profileController.imdbRatingAverage / 10,
                        color: kImdbColor,
                        backgroundColor: kImdbColor.withOpacity(0.15),
                        minHeight: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7.5,
                  ),
                  Text("Avarage IMDb rating",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  StatsChart(
                    index: 0,
                    statsName: "Genres",
                    items: [for (ShowPreview show in items) show.genres!],
                  ),
                  StatsChart(
                    index: 1,
                    statsName: "Countries",
                    items: [for (ShowPreview show in items) show.countries!],
                  ),
                  StatsChart(
                    index: 2,
                    statsName: "Languages",
                    items: [for (ShowPreview show in items) show.languages!],
                  ),
                  StatsChart(
                    index: 3,
                    statsName: "Companies",
                    items: [for (ShowPreview show in items) show.companies!],
                  ),
                  StatsChart(
                    index: 4,
                    statsName: "Contents",
                    items: [
                      for (ShowPreview show in items) show.contentRating!
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
