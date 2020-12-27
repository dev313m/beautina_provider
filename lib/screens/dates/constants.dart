//Colors
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ConstDatesColors {
  static Color background = AppColors.purpleColor;
  static Color rateTitle = Colors.yellow;
  static Color rateContainer = Colors.pink;

  static Color orderContainerBackground = Colors.black;
  static Color orderContainerTitle = AppColors.blue;
  static Color activeProgress = AppColors.blue;
  static Color notActiveProgress = AppColors.pinkOpcity;
  static Color services = AppColors.pinkOpcity;
  static Color details = Colors.orangeAccent;

  static Color confirmBtn = AppColors.blue;
  static Color cancelBtn = Colors.red.withOpacity(0.5);
  static Color littleList = AppColors.purpleOpcity;
  static Color topBtns = AppColors.pinkBright;
}

class CalendarColors {
  static Color container = ConstDatesColors.littleList.withAlpha(200);
  static Color todayContainer = Colors.orange;
  static Color eventColor = Colors.white24;
  static Color topNoti = Colors.blue;
  static Color bottomLeft = Colors.red;
  static Color bottomRight = Colors.blueGrey;
  static Color empty = Colors.white10;
  static Color header = Colors.white70;
  static Color headerContainer = Colors.pink;
  static Color orderDetailsBackground =
      ConstDatesColors.littleList.withAlpha(200);
}

//sizes
class ConstDateSizes {
  static var reloadBottom = 110;
  static var reloadWidth = 80;
  static var reloadHeight = 80;
  static var reloadLeft = reloadWidth / 2;
}
//Strings

class ConstDateStrings {
  static const delete = 'حذف من القائمة';
  static const favorite = 'المفضلة';
  static const finished = 'الطلبات المنتهية';
  static const cancel = 'الغاء';
  static const confirm = 'تأكيد';
}

final raduis = 15;
