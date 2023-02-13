import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movie_lab/constants/colors.dart';
import 'package:movie_lab/pages/main/search/search.dart';
import 'package:movie_lab/pages/main/search/search_bar/search_bar_controller.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        Get.find<SearchBarController>().controller;
    return GetBuilder<SearchBarController>(
      builder: (searchController) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: kBackgroundColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: (() {
                  doSearch();
                }),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Movie, TV Show or Person',
                    hintStyle: TextStyle(
                        color: kGreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.5),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  autocorrect: true,
                  controller: controller,
                  enableIMEPersonalizedLearning: true,
                  enableInteractiveSelection: true,
                  cursorColor: kPrimaryColor,
                  cursorHeight: 20,
                  enabled: true,
                  enableSuggestions: true,
                  onSubmitted: (text) => doSearch(),
                  onChanged: (value) =>
                      searchController.updateFieldState(text: value),
                  textInputAction: TextInputAction.search,
                  onTap: () {
                    searchController.updateFieldState(tapped: true);
                  },
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
