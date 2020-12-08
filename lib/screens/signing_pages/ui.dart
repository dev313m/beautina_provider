import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TextHlder extends StatelessWidget {
//   final double height;
//   final double width;
//   final Color borderColor;
//   final BorderRadius borderRadius;
//   final Function function;
//   final Widget textWidget;
//   final Color backgroundColor;
//   final Widget iconWidget;
//   final EdgeInsetsGeometry edgeInsetsGeometry;
//   TextHolder(
//       {Key key,
//       this.backgroundColor,
//       this.edgeInsetsGeometry,
//       this.iconWidget,
//       this.textWidget,
//       this.borderRadius,
//       this.width,
//       this.height,
//       this.borderColor,
//       this.function})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: borderRadius,
//         ),
//         child: InkWell(
//             onTap: () {
//               function();
//             },
//             child: Padding(
//               padding: edgeInsetsGeometry,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   textWidget,
//                   SizedBox(
//                     width: ScreenUtil().setWidth(8),
//                   ),
//                   iconWidget
//                 ],
//               ),
//             )));
//   }
// }
