import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class VMRootUi with ChangeNotifier {
  ///Page controller of all the app pages
  PreloadPageController pageController = PreloadPageController(
    initialPage: 3,
    keepPage: true,
  );
  int pageIndex = 3;

  ///Sliding pages of the app
  List<Widget> pages;

  /// Hide appbar top and buttom flag
  bool _hideBars = false;

  ///if notification page is visited flag
  bool isVisitedPage = false;

  ///If there is no internet flag
  bool _isNoInternet = false;

  ///Getters
  ///
  ///
  bool get isNoInternet => _isNoInternet;
  bool get hideBars => _hideBars;
  PreloadPageController getPageRootPageCntr() => pageController;

  ///setters

  set hideBars(bool hideBars) {
    _hideBars = hideBars;
    notifyListeners();
  }

  set isNoInternet(bool isNoInternet) {
    _isNoInternet = isNoInternet;
    notifyListeners();
  }
}
