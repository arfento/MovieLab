import 'package:get/get.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/modules/api/api_requester.dart';
import 'package:movie_lab/pages/main/search/search_bar/search_bar_controller.dart';

doSearch() async {
  final searchBarController = Get.find<SearchBarController>();
  searchBarController.setLoadingStatus(status: RequestResult.LOADING);
  try {
    await search().then((value) => {
          if (value)
            {
              searchBarController.setLoadingStatus(
                  status: RequestResult.SUCCESS)
            }
          else
            {
              searchBarController.setLoadingStatus(
                  status: RequestResult.FAILURE)
            }
        });
  } catch (e) {
    await Future.delayed(const Duration(seconds: 1));
    searchBarController.setLoadingStatus(status: RequestResult.FAILURE);
  }
}

Future<bool> search() async {
  final apiRequester = APIRequester();
  bool response = true;
  try {
    await apiRequester
        .search(searchType: "SearchMovie")
        .then((value) => {response = value});
    await apiRequester
        .search(searchType: "SearchSeries")
        .then((value) => {response = value});
    await apiRequester
        .search(searchType: "SearchName")
        .then((value) => {response = value});
    return response;
  } catch (e) {
    return false;
  }
}
