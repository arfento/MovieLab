import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_lab/constants/routes.dart';
import 'package:movie_lab/constants/themes.dart';
import 'package:get/get.dart';
import 'package:movie_lab/models/hive/hive_adapter/register_adapters.dart';
import 'package:movie_lab/models/hive/models/actor_preview.dart';
import 'package:movie_lab/models/hive/models/show_preview.dart';
import 'package:movie_lab/models/hive/models/user.dart';
import 'package:movie_lab/pages/main/home/home_data_controller.dart';
import 'package:movie_lab/pages/main/main_controller.dart';
import 'package:movie_lab/pages/main/main_page.dart';
import 'package:movie_lab/pages/main/profile/profile_controller.dart';
import 'package:movie_lab/pages/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  await initializeGetX();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String initRoute = splashScreenRoute;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieLab',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      initialRoute: initRoute,
      onUnknownRoute: (settings) {
        final matches =
            RegExp(r'(^\/title\/)(tt\d*)').firstMatch(settings.name.toString());
        if (matches?.group(1).toString() == "/title/" &&
            matches?.group(2).toString() != null) {
          return MaterialPageRoute(
            builder: (BuildContext context) => ItemPage(
              id: matches!.group(2).toString(),
            ),
          );
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      },
      routes: {
        splashScreenRoute: (context) => const SplashScreen(),
        homeScreenRoute: (context) => const MainPage(),
      },
    );
  }
}

Future? initializeHive() async {
  // Initialize Hive and Hive Flutter
  await Hive.initFlutter();
  registerAdapters();
  Hive.openBox<HiveUser>('user');
  Hive.openBox<HiveShowPreview>('collection');
  Hive.openBox<HiveShowPreview>('watchlist');
  Hive.openBox<HiveShowPreview>('history');
  Hive.openBox<HiveActorPreview>('artists');
}

Future? initializeGetX() async {
  // Initialize the controllers
  Get.put(MainController());
  Get.put(HomeDataController());
  Get.put(SearchBarController());
  Get.put(ProfileController());
  Get.put(CacheData());
}
