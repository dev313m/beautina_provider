import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flare_flutter/flare_actor.dart';

// class GetLoadingWidget extends StatelessWidget {
//   GetLoadingWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Loading(
//       // indicator: BallScaleIndicator(),
//       // size: 55,
//     ));
//   }
// }

class GetLoadingWidget extends StatelessWidget {
  const GetLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(100),
      child: FlareActor(
        'assets/rive/load.flr',

        // artboard: 'ic_empty_list_event_BK',
        // color: Colors.red,

        fit: BoxFit.fitHeight,
        animation: 'Untitled',
      ),
    );
  }
}
