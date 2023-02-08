import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_lab/constants/app.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/modules/Recommender/Recommender.dart';
import 'package:movie_lab/modules/tools/navigate.dart';
import 'package:movie_lab/modules/tools/system_ui_overlay_style.dart';
import 'package:movie_lab/pages/main/main_page.dart';
import 'package:movie_lab/pages/splash/get_initial_data.dart';
import 'package:movie_lab/pages/splash/get_user_data.dart';
import 'package:movie_lab/widgets/error.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.then}) : super(key: key);
  final VoidCallback? then;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RequestResult requestResult = RequestResult.LOADING;

  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle();
    _loadData();
  }

  void _launchUrl(final String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/images/logos/logo.png",
                  color: kPrimaryColor,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_loadErrorSwitch()],
            ),
          ],
        ),
      ),
    );
  }

  _loadErrorSwitch() {
    switch (requestResult) {
      case RequestResult.LOADING:
        return const Center(
          child: SpinKitRipple(
            color: kPrimaryColor,
            size: 100,
            borderWidth: 10,
          ),
        );
      case RequestResult.FAILURE_VERSION_PROBLEM:
        return ConnectionErrorWidget(
          tryAgain: () {
            _launchUrl(
              secureUrl ?? "https://erfanrht.github.io/MovieLab-Intro",
            );
          },
          isItTryAgain: false,
          errorText:
              'The version of MovieLab that you are using is outdated.\nFor more information check out:\n${secureUrl ?? "erfanrht.github.io/movielab-intro"}',
        );
      default:
        return ConnectionErrorWidget(
          tryAgain: () {
            setState(() {
              requestResult = RequestResult.LOADING;
            });
            _loadData();
          },
          errorText: requestResult == RequestResult.FAILURE_SERVER_PROBLEM
              ? 'An unexpected error occurred while loading data.'
              : 'Your internet connection is not working.',
        );
    }
  }

  Future _loadData() async {
    getInitialData().then((result) {
      if (result == RequestResult.SUCCESS) {
        recommender();
        getUserData();
        if (supportedVersions != null && supportedVersions!.isNotEmpty) {
          if (supportedVersions!.contains(appVersion)) {
            Navigate.replaceTo(context, const MainPage());
          } else {
            setState(() {
              requestResult = RequestResult.FAILURE_VERSION_PROBLEM;
            });
          }
        } else {
          Navigate.replaceTo(context, const MainPage());
        }
      } else {
        setState(() {
          requestResult = result;
        });
      }
    });
  }
}
