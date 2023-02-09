import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/constants/app.dart';
import 'package:movie_lab/constants/colors.dart';
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
import 'package:movie_lab/widgets/buttons/activeable_button.dart';
import 'package:movie_lab/widgets/error.dart';
import 'package:movie_lab/widgets/inefficacious_refresh_indicator.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future checkForUpdateDialog(BuildContext context, dynamic vsync) async {
    if (kDebugMode) {
      print("Checking for update dialog");
    }
    await Future.delayed(const Duration(milliseconds: 1999));
    if (latestVersion != null &&
        latestVersion != "" &&
        appVersion != latestVersion) {
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: kSecondaryColor,
          transitionAnimationController: AnimationController(
              duration: const Duration(milliseconds: 425), vsync: vsync),
          builder: (context) {
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: kBackgroundColor,
                height: 425,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(top: 8.5, bottom: 7.5),
                        height: 3,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      UnDraw(
                        color: kAccentColor,
                        illustration: UnDrawIllustration.upgrade,
                        height: 150,
                        placeholder: const Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        errorWidget: ConnectionErrorWidget(
                            errorText:
                                "An unexpected error occurred while loading the illustration.",
                            tryAgain: () {}),
                      ),
                      const Text(
                        "Update MovieLab",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.5),
                      ),
                      const SizedBox(
                        height: 7.5,
                      ),
                      Text(
                        "${latestVersion!.replaceAll('v', 'Version ')} · 21.0 MB",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.66)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Please update MovieLab to the latest version. The version you are using is out of date and may stop working soon.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ActiveableButton(
                        isActive: true,
                        text: "Download now!",
                        icon: null,
                        onTap: () {
                          _launchUrl(secureUrl ??
                              "https://erfanrht.github.io/MovieLab-Intro");
                        },
                        activeColor: kAccentColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Remind me later",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: kAccentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]));
          });
    }
  }

  void _launchUrl(final String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
