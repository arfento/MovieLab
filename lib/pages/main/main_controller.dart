import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  int selectedIndex = 0;

  changeIndex(int index) {
    if (index == selectedIndex) {
      if (index == 0) {
        homeScrollController.animateTo(0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
      if (index == 1) {
        // Search page may sometimes doesn't have a scroll controller, so we need to check it
        try {
          searchScrollController.animateTo(0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
          // ignore: empty_catches
        } catch (e) {}
      }
      if (index == 2) {
        // collection page may sometimes doesn't have a scroll controller, so we need to check it
        try {
          listsScrollController.animateTo(0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
          // ignore: empty_catches
        } catch (e) {}
      }
      if (index == 3) {
        profileScrollController.animateTo(0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
    } else {
      selectedIndex = index;
    }
    update();
  }

  // Main pages scroll controller
  ScrollController homeScrollController = ScrollController();
  ScrollController searchScrollController = ScrollController();
  ScrollController listsScrollController = ScrollController();
  ScrollController profileScrollController = ScrollController();

  // Active API key controller
  int activeApiKey = 0;

  changeActiveApiKey(int index) {
    activeApiKey = index;
    update();
  }
}
