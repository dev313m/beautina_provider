import 'package:beautina_provider/screens/gift/ui/flare.dart';
import 'package:beautina_provider/screens/gift/ui/image.dart';
import 'package:beautina_provider/screens/gift/ui/offer_container.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PageGift extends StatelessWidget {
  
  const PageGift({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Y(height: heightTopBar),
        GWdgtGiftFlare(),
        GWdgtGift50(),
        Y(),
        WdgtGiftOfferContainer(),
      ],
    );
  }
}
