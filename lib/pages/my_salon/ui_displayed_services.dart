import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/pages/my_salon/shared_mysalon.dart';
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
  List<Widget> getWidgetList() {
    Map<String, dynamic> mapper =
        Provider.of<SharedSalon>(context).providedServices;
    List<Widget> list = [];

    widget.mapServices.forEach((k, v) {
      Map<String, dynamic> testValue = mapper['services'];
      if (testValue.containsKey(k)) if (testValue[k]
          .containsKey('items')) if (testValue[k].containsKey('ar')) {
        list.add(SizedBox(height: ScreenUtil().setHeight(10)));

        list.add(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              // key: ValueKey('s'),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                ...getRowWidgets(v, k),
                TitleWidget(
                  image: mapper['services'][k]['ar'],
                ),
              ],
            ),
          ),
        );
      }
    });
    return list;
  }

  List<Widget> getRowWidgets(dynamic services, dynamic category) {
    Map<String, dynamic> mapper =
        Provider.of<SharedSalon>(context).providedServices;
    List<Widget> list = [];
    services.forEach((k, v) {
      Map<String, dynamic> testValue = mapper['services'];
      if (testValue.containsKey(category)) if (testValue[category].containsKey(
          'items')) if (testValue[category]['items'].containsKey(k))
        list.add(SingleService(
          serviceName: category == "other"
              ? k
              : mapper['services'][category]['items'][k]['ar']?.toString(),
          prices: v,
          serviceCode: k,
          serviceRoot: category,
          // priceBefore: v[0].toString(),
          // priceAfter: v[1]?.toString() ?? v[0].toString(),
        ));
      list.add(SizedBox(
        width: ScreenUtil().setWidth(10),
      ));
    });

    return list;
  }

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
          if (getWidgetList().length == 0)
            ExtendedText(
              string: "لم تقومي بإضافة اي خدمة",
            ),
          ...getWidgetList(),
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
