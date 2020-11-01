import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/screens/notification/index.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class WidgetServices extends StatefulWidget {
  final Map<String, dynamic> mapServices;
  WidgetServices({Key key, this.mapServices}) : super(key: key);

  @override
  _WidgetServicesState createState() => _WidgetServicesState();
}

class _WidgetServicesState extends State<WidgetServices> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white38,
      padding: EdgeInsets.only(
          bottom: ScreenUtil().setWidth(10),
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10)),
      child: Column(
        // key: ValueKey('value'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
          Container(
              height: ScreenUtil().setHeight(100),
              child: Center(
                  child: ExtendedText(
                      string: ' ~ خدماتي ~', fontSize: ExtendedText.xbigFont))),
          ExtendedText(
            string: '(قائمة خدماتك، ويمكنك حذف الخدمات من هنا)',
            fontColor: ExtendedText.brightColors2,
          ),

          if (widget.mapServices.keys.length > 0)
            ListView.builder(
              itemCount: widget.mapServices.keys.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              padding: EdgeInsets.all(5.w),
              addRepaintBoundaries: true,
              itemBuilder: (_, index) {
                Map<String, dynamic> allDefaultServicesMap =
                    Provider.of<SharedSalon>(context)
                        .providedServices['services'];
                // List<Widget> list = [];
                String mainServiceKey = widget.mapServices.keys.toList()[index];

                if (mainServiceKey == 'other')
                  return Container(
                    height: 158.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemBuilder: (_, rowIndex) {
                        String itemKey =
                            widget.mapServices['other'].keys.toList()[rowIndex];

                        return Padding(
                          padding: EdgeInsets.all(8.0.h),
                          child: SingleService(
                            serviceName: itemKey,
                            prices: widget.mapServices['other'][itemKey],
                            serviceCode: itemKey,
                            serviceRoot: mainServiceKey,
                            // priceBefore: v[0].toString(),
                            // priceAfter: v[1]?.toString() ?? v[0].toString(),
                          ),
                        );
                      },
                      itemCount: widget.mapServices[mainServiceKey].keys.length,
                    ),
                  );

                if (allDefaultServicesMap
                    .containsKey(mainServiceKey)) if (allDefaultServicesMap[
                        mainServiceKey]
                    .containsKey(
                        'items')) if (allDefaultServicesMap[mainServiceKey]
                    .containsKey('ar'))
                  return Container(
                    height: 158.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemBuilder: (_, rowIndex) {
                        String itemKey = widget.mapServices[mainServiceKey].keys
                            .toList()[rowIndex];

                        if (allDefaultServicesMap[mainServiceKey]['items']
                            .containsKey(itemKey))
                          return Padding(
                            padding: EdgeInsets.all(8.0.h),
                            child: SingleService(
                              serviceName: allDefaultServicesMap[mainServiceKey]
                                      ['items'][itemKey]['ar']
                                  ?.toString(),
                              prices: widget.mapServices[mainServiceKey]
                                  [itemKey],
                              serviceCode: itemKey,
                              serviceRoot: mainServiceKey,
                              // priceBefore: v[0].toString(),
                              // priceAfter: v[1]?.toString() ?? v[0].toString(),
                            ),
                          );
                        return SizedBox();
                      },
                      itemCount: widget.mapServices[mainServiceKey].keys.length,
                    ),
                  );
                return SizedBox();
              },

              // return list;

              addAutomaticKeepAlives: true,
            ),

          if (widget.mapServices.keys.length == 0)
            ExtendedText(
              string: "لم تقومي بإضافة اي خدمة",
            ),

          // ...getWidgetList(),
          SizedBox(height: ScreenUtil().setHeight(70))
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final image;
  const TitleWidget({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            // padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
            decoration: BoxDecoration(
              color: AppColors.purpleColor,
            ),
            height: ScreenUtil().setHeight(120),
            width: ScreenUtil().setHeight(120),
            child: Center(
                child: ExtendedText(
              string: image,
              fontSize: ExtendedText.bigFont,
            ))));
  }
}

class SingleService extends StatefulWidget {
  final String serviceName;
  final String serviceRoot;
  final String serviceCode;
  final List<dynamic> prices;

  const SingleService(
      {Key key,
      this.prices,
      this.serviceName,
      @required this.serviceRoot,
      @required this.serviceCode})
      : super(key: key);

  @override
  _SingleServiceState createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(120),
      padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(15),
          left: ScreenUtil().setWidth(15),
          right: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.blue.withOpacity(0.5),
      ),

      // padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ExtendedText(
              string: widget.serviceName,
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                if (widget.prices.length > 1)
                  ExtendedText(string: 'قبل: ${widget.prices[1]}   '),
                ExtendedText(string: 'السعر: ${widget.prices[0]}   '),
              ],
            ),
          ),
          InkWell(
              onTap: () async {
                /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */
                ModelBeautyProvider bp = await sharedUserProviderGetInfo();

                //2
                Map<String, dynamic> newMap = bp.servicespro;
                newMap[widget.serviceRoot].remove(widget.serviceCode);
                try {
                  loading = true;
                  setState(() {});
                  Provider.of<SharedSalon>(context).beautyProvider =
                      await apiBeautyProviderUpdate(bp..servicespro = newMap);
                  showToast('تم التحديث');
                } catch (e) {
                  showToast('حدثت مشكلة، لم يتم التحديث');
                }
                loading = false;
                setState(() {});
              },
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: durationCalender),
                  child: loading
                      ? Loading()
                      : Icon(CommunityMaterialIcons.delete_circle,
                          color: Colors.white70)))
        ],
      ),
    );
  }
}
