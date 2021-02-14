import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageGift extends StatelessWidget {
  const PageGift({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Y(height: heightNavBar),
        GWdgtGiftFlare(),
        GWdgtGift50(),
      ],
    );
  }
}

class GWdgtGift50 extends StatelessWidget {
  const GWdgtGift50({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000.h,
      child: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/50.png',
                // height: 800.h,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: GWdgtTextTitle(string: '50 = 3500'))
        ],
      ),
    );
  }
}

class GWdgtGiftFlare extends StatelessWidget {
  const GWdgtGiftFlare({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
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
