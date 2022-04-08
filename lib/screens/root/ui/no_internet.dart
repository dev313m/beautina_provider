import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetNoConnection extends StatelessWidget {
  const WidgetNoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(noConnectionBorderRadius),
          color: noConnectionContainerColor,
        ),
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 4,
        child: FlareActor(
          'assets/rive/noconnection.flr',
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
          animation: 'no_netwrok',
        ),
      ),
    );
  }
}

///[Colors]
final Color noConnectionContainerColor = Colors.black.withOpacity(0.5);

///[Sizes]
final double mainContainerWidth = 0.1.sw;
final double mainContainerHeight = 0.1.sh;

///[Border raduis]
const double noConnectionBorderRadius = 13;
