import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class VMRootUi with ChangeNotifier {
  PreloadPageController pageController = PreloadPageController(
    initialPage: 3,
    keepPage: true,
  );
  List<Widget> pages;
  bool _hideBars = false;
  bool isVisitedPage = false; //if notification page is visited

  bool get hideBars => _hideBars;

  set hideBars(bool hideBars) {
    _hideBars = hideBars;
    notifyListeners();
  }

  // navigateBtwPages(BuildContext context, int index) {
  //   pageController.jumpTo(index.toDouble());
  //   notifyListeners();
  // }

  PreloadPageController getPageRootPageCntr() => pageController;
}
