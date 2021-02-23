import 'package:beautina_provider/screens/gift/ui/alert.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:emojis/emoji.dart'; // to use Emoji utilities
import 'package:flutter/material.dart';

class WdgtGiftOfferContainer extends StatelessWidget {
  const WdgtGiftOfferContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.h),
      width: 0.95.sw,
      // height: ,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.yellow.withOpacity(0.3)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                GWdgtTextTitleDesc(
                  color: Colors.white,
                  string:
                      ' ${Emoji.byName('two hearts').char} لكل 50 طلب تسويق ممول مجاني لزيادة شهرتك ${Emoji.byName('two hearts').char}',
                ),
                Y(),
                Y(),
                GWdgtTextTitleDesc(
                  color: Colors.white,
                  string: 'مجموع نقاطي',
                ),
                Y(),
                GWdgtTextTitleDesc(
                  color: Colors.white,
                  string: Provider.of<VMSalonData>(context)
                          .beautyProvider
                          .customers
                          .toInt()
                          .toString() +
                      "/ 50",
                ),
                if (Provider.of<VMSalonData>(context)
                        .beautyProvider
                        .customers >=
                    50)
                  GWdgtTextTitleDesc(
                    color: Colors.white,
                    string:
                        "مبروك، سيتم التواصل معك قريبا  ${Emoji.byName('two hearts').char}",
                  ),
                Y(),
                Y(),
                Y(),
                InkWell(
                  child: Column(
                    children: [
                      GWdgtTextTitleDesc(
                        color: Colors.yellow,
                        string: 'المزيد',
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  onTap: () async {
                    showOfferAlert(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
