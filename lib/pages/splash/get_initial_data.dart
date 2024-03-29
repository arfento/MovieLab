import 'package:get/get.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/modules/api/api_requester.dart';
import 'package:movie_lab/pages/main/home/home_data_controller.dart';

Future<RequestResult> getInitialData() async {
  final apiRequester = APIRequester();
  try {
    await apiRequester.getTrendingMovies();
    await apiRequester.getTrendingTVShows();
    await apiRequester.getInTheaters();
  } catch (e) {
    await Future.delayed(Duration(seconds: 2));
    return RequestResult.FAILURE_USER_PROBLEM;
  }
  if (Get.find<HomeDataController>().trendingMovies.isNotEmpty ||
      Get.find<HomeDataController>().trendingShows.isNotEmpty ||
      Get.find<HomeDataController>().inTheaters.isNotEmpty) {
    return RequestResult.SUCCESS;
  }
  return RequestResult.FAILURE_SERVER_PROBLEM;
}
