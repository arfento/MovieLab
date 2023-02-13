import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_lab/constants/types.dart';
import 'package:movie_lab/models/item_models/show_models/show_preview_model.dart';

class SearchBarController extends GetxController {
  RequestResult requestResult = RequestResult.NOT_STARTED;
  bool fieldTapped = false;
  String fieldText = "";
  TextEditingController controller = TextEditingController();

  List<ShowPreview>? movieResult;
  List<ShowPreview>? seriesResult;
  List<ShowPreview>? peopleResult;

  setLoadingStatus({required RequestResult status}) {
    requestResult = status;
    update();
  }

  void updateFieldState({bool? tapped, String? text}) {
    fieldTapped = tapped ?? fieldTapped;
    fieldText = text ?? fieldText;
    update();
  }

  void updateResult({movieResult, seriesResult, peopleResult}) {
    this.movieResult = movieResult ?? this.movieResult;
    this.seriesResult = seriesResult ?? this.seriesResult;
    this.peopleResult = peopleResult ?? this.peopleResult;
    update();
  }
}
