import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flare_flutter/flare_actor.dart';

class GWdgtGiftFlare extends StatelessWidget {
  const GWdgtGiftFlare({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      child: Stack(
        children: [
          FlareActor(
            'assets/rive/gift.flr',
            fit: BoxFit.fitHeight,
            animation: 'idle',
          ),
        ],
      ),
    );
  }
}
