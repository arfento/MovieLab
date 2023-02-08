import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movie_lab/.api.dart';
import 'package:http/http.dart' as http;
import 'package:movie_lab/constants/app.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/models/item_models/show_models/show_preview_model.dart';
import 'package:movie_lab/modules/api/key_getter.dart';
import 'package:movie_lab/pages/main/home/home_data_controller.dart';

class APIRequester {
  static const String imdbBaseUrl = 'https://imdb-api.com/en/API';
  // API keys to access the IMDB API:
  static int activeApiKey = Random().nextInt(apiKeys.length);
  static List<int> notWorkingApiKeys = [];

  Future<RequestResult> getTrendingMovies() async {
    final response = await getUrl(
      order: "MostPopularMovies",
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> trendingMovies = [];
      for (int i = 0; i < json.length; i++) {
        if (!unavailableIDs.contains(json[i]["id"])) {
          trendingMovies.add(ShowPreview.fromJson(json[i]));
        }
      }
      Get.find<HomeDataController>()
          .updateTrendingMovies(trendingMovies: trendingMovies);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  Future<RequestResult> getTrendingTVShows() async {
    final response = await getUrl(
      order: "MostPopularTVs",
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> trendingShows = [];
      for (int i = 0; i < json.length; i++) {
        if (!unavailableIDs.contains(json[i]["id"])) {
          trendingShows.add(ShowPreview.fromJson(json[i]));
        }
      }
      Get.find<HomeDataController>()
          .updateTrendingShows(trendingShows: trendingShows);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  Future<RequestResult> getInTheaters() async {
    final response = await getUrl(
      order: "InTheaters",
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> inTheaters = [];
      for (int i = 0; i < json.length; i++) {
        if (!unavailableIDs.contains(json[i]["id"])) {
          inTheaters.add(ShowPreview.fromJson(json[i]));
        }
      }
      Get.find<HomeDataController>().updateInTheaters(inTheaters: inTheaters);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  Future<bool> getIMDBlists({required ImdbList listName}) async {
    HomeDataController homeDataController = Get.find<HomeDataController>();

    http.Response response;
    switch (listName) {
      case ImdbList.TOP_250_MOVIES:
        response = await getUrl(order: "Top250Movies");
        break;
      case ImdbList.TOP_250_TVS:
        response = await getUrl(order: "Top250TVs");
        break;
      case ImdbList.BoxOffice:
        response = await getUrl(order: "BoxOffice");
        break;
      case ImdbList.AllTimeBoxOffice:
        response = await getUrl(order: "BoxOfficeAllTime");
        break;
    }

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> resultList = [];
      for (int i = 0; i < json.length; i++) {
        resultList.add(ShowPreview.fromJson(json[i]));
      }
      switch (listName) {
        case ImdbList.TOP_250_MOVIES:
          homeDataController.updateTopRatedMovies(topRatedMovies: resultList);
          break;
        case ImdbList.TOP_250_TVS:
          homeDataController.updateTopRatedShows(topRatedShows: resultList);
          break;
        case ImdbList.BoxOffice:
          homeDataController.updateBoxOffice(boxOffice: resultList);
          break;
        case ImdbList.AllTimeBoxOffice:
          homeDataController.updateAllTimeBoxOffice(
              allTimeBoxOffice: resultList);
          break;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<Map?> getCompany({required String id}) async {
    final response = await getUrl(order: "Company", id: id);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> companyMovies = [];
      for (var i = 0; i < json.length; i++) {
        companyMovies.add(ShowPreview.fromJson(json[i]));
      }
      return {
        "name": jsonDecode(response.body)["name"],
        "movies": companyMovies,
      };
    } else {
      return null;
    }
  }

  // Get popular movies/series of a specific genre
  Future<List<ShowPreview>?> getGenreItems({required String genre}) async {
    final response =
        await getUrl(order: "AdvancedSearch", id: "?genres=$genre");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["results"];
      List<ShowPreview> result = [];
      for (int i = 0; i < json.length; i++) {
        result.add(ShowPreview.fromJson(json[i]));
      }
      return result;
    } else {
      return null;
    }
  }

  Future getUrl(
      {required String order,
      String? id,
      String? season,
      String? additionals}) async {
    String url;
    if (apiKeys.isEmpty ||
        (apiKeys.length == 1 && apiKeys[0] == "XXXXXXXXXX")) {
      var response;
      await key_getter().then((result) async {
        if (result == RequestResult.FAILURE) {
          if (kDebugMode) {
            print(
                "You haven't add any api key to the app, so it won't work!\nFor more information check out the documentation at https://github.com/ErfanRht/MovieLab#getting-started");
          }
          response = null;
        } else {
          await getUrl(
                  order: order,
                  id: id,
                  season: season,
                  additionals: additionals)
              .then((responseBody) {
            response = responseBody;
          });
          return response;
        }
        return response;
      });
      return response;
    } else if (apiKeys.isNotEmpty) {
      if (id != null && season != null) {
        url = "$imdbBaseUrl/$order/${apiKeys[activeApiKey]}/$id/$season";
      } else if (id != null) {
        if (additionals != null) {
          url = "$imdbBaseUrl/$order/${apiKeys[activeApiKey]}/$id/$additionals";
        } else {
          url = "$imdbBaseUrl/$order/${apiKeys[activeApiKey]}/$id";
        }
      } else {
        url = "$imdbBaseUrl/$order/${apiKeys[activeApiKey]}";
      }
      var response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 10),
          );
      if (jsonDecode(response.body)['errorMessage'] != "" &&
          jsonDecode(response.body)['errorMessage'] != null) {
        // Here we handle the IMDb API limit error
        // If the API key is invalid, change it to the next one
        if (kDebugMode) {
          if (jsonDecode(response.body)['errorMessage'] == "Invalid API Key") {
            print("${apiKeys[activeApiKey]} is Invalid");
            notWorkingApiKeys.add(activeApiKey);
            // $activeApiKey has been added to notWorkingApiKeys
          } else {
            print("Server error: ${jsonDecode(response.body)['errorMessage']}");
            notWorkingApiKeys.add(activeApiKey);
            // $activeApiKey has been added to notWorkingApiKeys
          }
        }

        while (true) {
          if (notWorkingApiKeys.length < apiKeys.length) {
            activeApiKey = Random().nextInt(apiKeys.length);
            if (!notWorkingApiKeys.contains(activeApiKey)) {
              if (kDebugMode) {
                print("activeApiKey has been changed to: $activeApiKey");
              }
              await getUrl(
                      order: order,
                      id: id,
                      season: season,
                      additionals: additionals)
                  .then((value) {
                response = value;
              });
              break;
            }
          } else {
            if (kDebugMode) {
              print(
                  "There is no working api keys available anymore! It's done.");
            }
            break;
          }
        }
      }
      return response;
    }
  }
}
