import 'package:flutter/material.dart';
import 'package:movie_lab/models/item_models/show_models/show_preview_model.dart';
import 'package:movie_lab/modules/preferences/preferences_shareholder.dart';
import 'package:movie_lab/pages/splash/get_user_data.dart';

class UserStats extends StatelessWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShowPreview> items = [];
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    items = getAllItems(allLists: preferencesShareholder.getAllLists());

    return Container();
  }
}
