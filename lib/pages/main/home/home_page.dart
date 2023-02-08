import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/models/hive/convertor.dart';
import 'package:movie_lab/models/hive/models/show_preview.dart';
import 'package:movie_lab/pages/main/home/home_data_controller.dart';
import 'package:movie_lab/pages/main/home/sections/box_office/box_office.dart';
import 'package:movie_lab/pages/main/home/sections/companies/companies.dart';
import 'package:movie_lab/pages/main/home/sections/genres/genres.dart';
import 'package:movie_lab/pages/main/home/sections/imdb_lists/lists.dart';
import 'package:movie_lab/pages/main/home/sections/navbar/navbar.dart';
import 'package:movie_lab/pages/main/home/sections/trendings/home_trendings.dart';
import 'package:movie_lab/pages/main/main_controller.dart';
import 'package:movie_lab/widgets/inefficacious_refresh_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (mainController) {
        return GetBuilder<HomeDataController>(
          builder: (homeController) {
            return ValueListenableBuilder<Box<HiveShowPreview>>(
              valueListenable:
                  Hive.box<HiveShowPreview>("collection").listenable(),
              builder: (context, collectionBox, child) {
                final collection =
                    collectionBox.values.toList().cast<HiveShowPreview>();

                return ValueListenableBuilder<Box<HiveShowPreview>>(
                    valueListenable:
                        Hive.box<HiveShowPreview>("watchlist").listenable(),
                    builder: (context, watchlistBox, ___) {
                      final watchlist =
                          watchlistBox.values.toList().cast<HiveShowPreview>();
                      return Scaffold(
                        body: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 70),
                              child: InefficaciousRefreshIndicator(
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  controller:
                                      mainController.homeScrollController,
                                  children: [
                                    HomeTrendingsBuilder(
                                        trendings:
                                            homeController.trendingMovies,
                                        title: "Trending Movies"),
                                    HomeTrendingsBuilder(
                                        trendings: homeController.trendingShows,
                                        title: "Trending TV Shows"),
                                    homeController.recommendations.length > 10
                                        ? HomeTrendingsBuilder(
                                            trendings:
                                                homeController.recommendations,
                                            title: "Recommended For You")
                                        : const SizedBox.shrink(),
                                    HomeTrendingsBuilder(
                                        trendings: homeController.inTheaters,
                                        title: "Currently In Theatres"),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: HomePopularGenres(
                                          title: 'Popular Genres'),
                                    ),
                                    watchlist.isNotEmpty
                                        ? HomeTrendingsBuilder(trendings: [
                                            for (HiveShowPreview hive
                                                in watchlist)
                                              convertHiveToShowPreview(hive)
                                          ], title: "Your Watchlist")
                                        : const SizedBox.shrink(),
                                    collection.isNotEmpty
                                        ? HomeTrendingsBuilder(trendings: [
                                            for (HiveShowPreview hive
                                                in collection)
                                              convertHiveToShowPreview(hive)
                                          ], title: "Your Collection")
                                        : const SizedBox.shrink(),
                                    const HomeIMDbLists(title: 'IMDb Lists'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const HomePopularCompanies(
                                      title: 'Popular Companies',
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const HomeBoxOffice(
                                      title: 'Box Office',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: const [
                                HomeNavbar(),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
            );
          },
        );
      },
    );
  }
}
