import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class WdgtSalonCloseOpenSalon extends StatefulWidget {
  WdgtSalonCloseOpenSalon({Key key}) : super(key: key);

  @override
  _WdgtSalonCloseOpenSalonState createState() => _WdgtSalonCloseOpenSalonState();
}

class _WdgtSalonCloseOpenSalonState extends State<WdgtSalonCloseOpenSalon> {
  bool availableLoad = false;
  ModelBeautyProvider beautyProvider;
  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;

    return Column(
      children: [
        Container(
          height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                    child: ExtendedText(
                  string: 'فتح - اغلاق صالوني',
                  fontSize: ExtendedText.xbigFont,
                )),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: ExtendedText(
                  string: '(اضغط على المصباح لإخفاء ظهورك عند البحث)',
                  fontColor: ExtendedText.brightColors2,
                ),
              )
            ],
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(399),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              // width: 400,

              height: ScreenUtil().setHeight(399),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () async {
                  availableLoad = true;
                  setState(() {});
                  try {
                    /**
                             * 1- get now beautyProvider from shared
                             * 2- update and save in shared
                             * 3- get shared and notifylisteners
                             */
                    ModelBeautyProvider mbp = await sharedUserProviderGetInfo();

                    await apiBeautyProviderUpdate(mbp..available = !mbp.available);

                    // Provider.of<VMSalonData>(context).beautyProvider = mbp;
                    // setState(() {});
                    Provider.of<VMSalonData>(context).beautyProvider = await sharedUserProviderGetInfo();
                    // var don;
                  } catch (e) {
                    showToast('حدث خطأ اثناء التحديث');
                  }

                  availableLoad = false;
                },
                child: Stack(
                  children: <Widget>[
                    FlareActor(
                      'assets/rive/bulb.flr',

                      animation: beautyProvider.available ? 'lightOn' : 'lightOff',
                      shouldClip: false,
                      snapToEnd: false,
                      // controller: ,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: availableLoad ? Loading() : SizedBox(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
