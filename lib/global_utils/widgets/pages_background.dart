import 'package:beautina_provider/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class GlobalWidgetBackground extends StatelessWidget {
  final Widget? child;
  const GlobalWidgetBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                UtilsGlobalColor.backgroundTop,
                UtilsGlobalColor.backgroundbuttom,                  
              ],
              begin: const FractionalOffset(1.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.mirror),
        ),
        child: child);
  }
}
