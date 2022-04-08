import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPainter extends CustomPainter {
  int step;
  MyPainter({required this.step});
  @override
  void paint(Canvas canvas, Size size) {
    List<Paint> paintList = getPaintList(size.width, step);
    double endOfLint = .399;
    double startofLine = .699;
    double width = size.width;

    int i = 0;
    final TextPainter textPainter1 = TextPainter(
        text: TextSpan(text: 'حالة الطلب', style: TextStyle(fontSize: ScreenUtil().setSp(15), color: Colors.white)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: width);
    textPainter1.paint(canvas, Offset(width * 0.9, size.height * 0.3));

    canvas.drawCircle(Offset(startofLine * width, size.width / 10), size.width / 16, paintList.elementAt(i));

    while (endOfLint > 0.0) {
      canvas.drawLine(Offset(startofLine * width, size.width / 10), Offset(endOfLint * width, size.width / 10), paintList.elementAt(i));
      canvas.drawCircle(Offset(endOfLint * width, size.width / 10), size.width / 16, paintList.elementAt(i + 1));
      endOfLint -= 0.3;
      startofLine -= 0.3;

      i++;
    }
    i = 0;
    startofLine = .645;

    while (startofLine > 0.0) {
      getTextPaint(width).elementAt(i).paint(canvas, Offset(width * startofLine, 0));
      startofLine -= 0.3;
      i++;
    }
  }

  List<Paint> getPaintList(double width, int step) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = width / 30
      ..color = ConstDatesColors.activeProgress
      ..isAntiAlias = true;

    var paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = width / 30
      ..color = ConstDatesColors.notActiveProgress
      ..isAntiAlias = true;

    if (step == 0)
      return [paint, paint2, paint2];
    else if (step == 1) {
      return [paint, paint, paint2];
    } else
      return [paint, paint, paint];
  }

  List<TextPainter> getTextPaint(double width) {
    final TextPainter textPainter1 = TextPainter(
        text: TextSpan(text: 'طلب جديد', style: TextStyle(fontSize: 10, color: Colors.white)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: width);
    final TextPainter textPainter2 = TextPainter(
        text: TextSpan(text: 'قبول الطلب', style: TextStyle(fontSize: 10, color: Colors.white)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: width);

    final TextPainter textPainter3 = TextPainter(
        text: TextSpan(text: 'تأكيد الزبون', style: TextStyle(fontSize: 10, color: Colors.white)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: width);

    return [textPainter1, textPainter2, textPainter3];
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
