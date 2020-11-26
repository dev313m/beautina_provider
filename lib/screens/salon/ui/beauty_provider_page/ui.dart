// import 'dart:js';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/constants.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/functions.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Widget beautyProviderName(ModelBeautyProvider modelBeautyProvider) {
  return ExtendedText(string: modelBeautyProvider.name, fontSize: ExtendedText.bigFont, fontColor: Colors.pink);
}

class OrderUi {
  OrderFunctions _orderFunctions = OrderFunctions();
  Widget operationCountWidget(ModelBeautyProvider modelBeautyProvider) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            _orderFunctions.infoStr + modelBeautyProvider.name,
            overflow: TextOverflow.fade, // it wont aloow the the text to go in a new line
            style: TextStyle(fontSize: 13.0, fontFamily: 'Tajawal'),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget muteRowCell(String count, String type, IconData icon, Color color, Function function) => Container(
        width: ScreenUtil().setWidth(140),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: new Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                icon,
                size: 25,
                color: color,
              ),
              onPressed: () async {
                await function();
              },
              splashColor: color,
              color: color,
              tooltip: type,
            ),
            new Text(
              '$count',
              style: new TextStyle(
                color: color.withOpacity(0.5),
                fontFamily: 'Tajawal',
              ),
            ),
            new Text(type,
                style: new TextStyle(
                  color: color,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Tajawal',
                ))
          ],
        ),
      );
}

class RowCell extends StatefulWidget {
  final int count;
  final String type;
  final IconData icon;
  final Color color;
  RowCell({Key key, this.color, this.count, this.icon, this.type}) : super(key: key);

  _RowCellState createState() => _RowCellState();
}

class _RowCellState extends State<RowCell> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            widget.icon,
            size: 25,
            color: widget.color,
          ),
          onPressed: () async {},
          splashColor: widget.color,
          color: widget.color,
          tooltip: widget.type,
        ),
        new Text(
          widget.count.toString(),
          style: new TextStyle(
            color: widget.color.withOpacity(0.5),
            fontFamily: 'Tajawal',
          ),
        ),
        new Text(widget.type.toString(),
            style: new TextStyle(
              color: widget.color,
              fontWeight: FontWeight.normal,
              fontFamily: 'Tajawal',
            ))
      ],
    ));
  }
}

class OrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width / 3,
      height: _width / 8,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.greenAccent,
        color: AppColors.pinkOpcity,
        child: InkWell(
          key: GlobalKey(),
          borderRadius: new BorderRadius.circular(20),
          splashColor: Colors.pinkAccent,
          highlightColor: Colors.pink,
          // onTap: () => bbc.swap(),
          child: Center(
            child: Text(
              ConstShopStrings.book,
              style: TextStyle(
                  // color: Color(0xff192a56),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal'),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleTransWidget extends StatelessWidget {
  final String img;
  CircleTransWidget({Key key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width / 6;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              img,
            ),
          ),
          gradient: LinearGradient(begin: FractionalOffset.centerRight, end: FractionalOffset.centerLeft, colors: [
            Colors.blue,
            Colors.yellow.withAlpha(9),
          ], stops: [
            0.0,
            0.9
          ])),
    );
  }
}
