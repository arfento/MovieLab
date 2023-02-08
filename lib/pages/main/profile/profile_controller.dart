import 'package:get/get.dart';

class ProfileController extends GetxController {
  late String name, username, imageUrl;

  updateUSerInfo({String? name, String? username, String? imageUrl}) {
    this.name = name ?? this.name;
    this.username = username ?? this.username;
    this.imageUrl = imageUrl ?? this.imageUrl;
    update();
  }

  String? nameErrorText, usernameErrorText;
  updateTextFields(
      {final String? nameErrorText, final String? usernameErrorText}) {
    this.nameErrorText = nameErrorText ?? this.nameErrorText;
    this.usernameErrorText = usernameErrorText ?? this.usernameErrorText;
    update();
  }

  int watchedMoviesCount = 0;
  int watchedSeriesCount = 0;
  updateWatchedMoviesCount(int count) {
    watchedMoviesCount = count;
    update();
  }

  updateWatchedSeriesCount(int count) {
    watchedSeriesCount = count;
    update();
  }

  double imdbRatingAverage = 0;
  updateImdbRatingAverage(double value) {
    imdbRatingAverage = value;
    update();
  }
}
