import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/global_utils/widgets/blur_container.dart';

class UiHomeToggleBar extends StatelessWidget {
  const UiHomeToggleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              children: [
                UiHomeHelperToggleItem(
                  text: 'الكل',
                ),
                UiHomeHelperToggleItem(
                  text: 'عزاء',
                  isChoose: true,
                ),
                UiHomeHelperToggleItem(
                  text: 'سفرة ام البنين عليها السلام',
                ),
                UiHomeHelperToggleItem(
                  text: 'تطبير',
                ),
                UiHomeHelperToggleItem(
                  text: 'محاظرات',
                ),
              ],
              isSelected: [false, false, false, true, true],
              selectedColor: Colors.white,
              borderColor: Colors.transparent,
              disabledBorderColor: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              disabledColor: Colors.white.withOpacity(0.6),
              borderWidth: 0,
              color: Colors.blue,
            ),
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.date_range,
              color: Color(0x6C35052E),
              size: 40.sp,
            ),
            onPressed: () {})
      ],
    );
  }
}

class UiHomeHelperToggleItem extends StatelessWidget {
  final String text;

  /// Wheater this choise is chosen or not
  final bool isChoose;
  const UiHomeHelperToggleItem({Key key, this.text, this.isChoose = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalWidgetBlurContainer(
      backgroundColor: isChoose ? Colors.black : Colors.white,
      opcity: 0.14,
      blurLevel: .5,
      height: 40,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
