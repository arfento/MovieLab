import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_lab/modules/tools/capitalizer.dart';
import 'package:movie_lab/modules/tools/navigate.dart';
import 'package:movie_lab/pages/main/profile/list_page/sections/stats_page/stats.dart';
import 'package:movie_lab/pages/shared/about_recommendations_page/about_recommendations.dart';

AppBar listPageNavbar(context, {required final String listName}) {
  return AppBar(
    centerTitle: false,
    leading: IconButton(
      icon: const Icon(
        FontAwesomeIcons.arrowLeft,
        color: Colors.white,
        size: 22.5,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Row(
      children: [
        Text(listName.capitalize(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    ),
    actions: [
      IconButton(
        icon: Icon(
          listName == "recommendations"
              ? Icons.more_horiz_rounded
              : FontAwesomeIcons.squarePollVertical,
          size: listName == "recommendations" ? 30 : 24,
        ),
        onPressed: () {
          Navigate.pushTo(
              context,
              listName == "recommendations"
                  ? const AboutRecommendations()
                  : ListStatsPage(
                      listName: listName,
                    ));
        },
      ),
    ],
  );
}
