import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_lab/constants/app.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/pages/app_name.dart';
import 'package:movie_lab/widgets/buttons/social_media_button.dart';
import 'package:movie_lab/widgets/default_appbar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, title: "About"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75),
                  child: Image.asset(
                    "assets/images/logos/logo.png",
                    color: kPrimaryColor,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(bottom: 5, child: AppName())
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Version ${appVersion.replaceAll('v', '')}",
              style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 225,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kSecondaryColor),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Text(
                        "Developed and designed by",
                        style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Erfan Rahmati",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SocialMediaButton(
                            icon: FontAwesomeIcons.github,
                            url: "https://github.com/",
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.linkedin,
                            url: "https://www.linkedin.com/in/",
                          ),
                          SocialMediaButton(
                            icon: Icons.email_rounded,
                            url: "mailto:arfento@gmail.com",
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.chrome,
                            url: "https://github.io/",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(0.75),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("assets/images/no_picture.png",
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
