import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading/loading.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

class WdgtSalonMyServices extends StatefulWidget {
  WdgtSalonMyServices({Key key}) : super(key: key);

  @override
  _WdgtSalonMyServicesState createState() => _WdgtSalonMyServicesState();
}

class _WdgtSalonMyServicesState extends State<WdgtSalonMyServices> {
  Map<String, dynamic> mapServices;
  String mainServiceKey;
  Map<String, dynamic> allDefaultServicesMap;
  String itemKey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VMSalonDataTest>(builder: (vMSalonData) {
      mapServices = vMSalonData.beautyProvider.servicespro;

      return ClipRRect(
        borderRadius: BorderRadius.circular(radiusContainer),
        child: Container(
          height: 0.4.sh,
          width: MediaQuery.of(context).size.width,
          color: colorContainerBg,
          child: Padding(
            padding: EdgeInsets.all(edgeMainContainer),
            child: Stack(
              children: [
                Align(
                    child: IconButton(
                      icon: Icon(Icons.edit_off, color: Colors.white24),
                    ),
                    alignment: Alignment.topLeft),
                Column(
                  // key: ValueKey('value'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    Y(
                      height: BoxHeight.heightBtwTitle,
                    ),
                    GWdgtTextTitle(string: strMyServices),
                    Y(
                      height: BoxHeight.heightBtwContainers,
                    ),
                    GWdgtTextTitleDesc(
                      string: strMyServicesDesc,
                      // fontColor: ExtendedText.brightColors2,
                    ),

                    Y(
                      height: BoxHeight.heightBtwTitle,
                    ),

                    if (mapServices.keys.length > 0)
                      ListView.builder(
                        itemCount: mapServices.keys.length,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(5.w),
                        addRepaintBoundaries: true,
                        itemBuilder: (_, index) {
                          allDefaultServicesMap = Get.find<VMSalonDataTest>()
                              .providedServices['services'];
                          // List<Widget> list = [];
                          mainServiceKey = mapServices.keys.toList()[index];

                          if (mainServiceKey == 'other')
                            return Container(
                              height: sizeElementListContainer,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                itemBuilder: (_, rowIndex) {
                                  String itemKey = mapServices['other']
                                      .keys
                                      .toList()[rowIndex];

                                  return SingleService(
                                    serviceName: itemKey,
                                    prices: mapServices['other'][itemKey],
                                    serviceCode: itemKey,
                                    serviceRoot: mainServiceKey,
                                    duration: vMSalonData.beautyProvider
                                        .service_duration[itemKey],
                                    // priceBefore: v[0].toString(),
                                    // priceAfter: v[1]?.toString() ?? v[0].toString(),
                                  );
                                },
                                itemCount:
                                    mapServices[mainServiceKey].keys.length,
                              ),
                            );

                          if (allDefaultServicesMap.containsKey(
                              mainServiceKey)) if (allDefaultServicesMap[
                                  mainServiceKey]
                              .containsKey('items')) if (allDefaultServicesMap[
                                  mainServiceKey]
                              .containsKey('ar'))
                            return Container(
                              height: sizeElementListContainer,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                itemBuilder: (_, rowIndex) {
                                  itemKey = mapServices[mainServiceKey]
                                      .keys
                                      .toList()[rowIndex];

                                  if (allDefaultServicesMap[mainServiceKey]
                                          ['items']
                                      .containsKey(itemKey))
                                    return SingleService(
                                      serviceName:
                                          allDefaultServicesMap[mainServiceKey]
                                                  ['items'][itemKey]['ar']
                                              ?.toString(),
                                      prices: mapServices[mainServiceKey]
                                          [itemKey],
                                      serviceCode: itemKey,
                                      serviceRoot: mainServiceKey,
                                      duration: vMSalonData.beautyProvider
                                          .service_duration[itemKey],

                                      // priceBefore: v[0].toString(),
                                      // priceAfter: v[1]?.toString() ?? v[0].toString(),
                                    );
                                  return SizedBox();
                                },
                                itemCount:
                                    mapServices[mainServiceKey].keys.length,
                              ),
                            );
                          return SizedBox();
                        },
                      ),

                    if (mapServices.keys.length == 0)
                      GWdgtTextTitleDesc(
                        string: strThereIsNoServices,
                      ),

                    // ...getWidgetList(),
                    // SizedBox(height: ScreenUtil().setHeight(70))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SingleService extends StatefulWidget {
  final String serviceName;
  final String serviceRoot;
  final String serviceCode;
  final List<dynamic> prices;
  final int duration;

  const SingleService(
      {Key key,
      this.prices,
      this.duration,
      this.serviceName,
      @required this.serviceRoot,
      @required this.serviceCode})
      : super(key: key);

  @override
  _SingleServiceState createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  bool loading = false;
  Duration _duration;
  @override
  void initState() {
    super.initState();
    _duration = Duration(minutes: widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(edgeElementContainer),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSingleElement),
          color: colorSingleElement,
        ),

        // padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edgeText,
              ),
              child: GWdgtTextTitleDesc(
                string: widget.serviceName,
              ),
            ),
            CustomDivider(
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edgeText,
              ),
              child: Row(
                children: <Widget>[
                  if (widget.prices.length > 1)
                    GWdgtTextTitleDesc(string: 'قبل: ${widget.prices[1]}   '),
                  GWdgtTextTitleDesc(string: ' ${widget.prices[0]} ريال'),
                ],
              ),
            ),
            CustomDivider(
              height: 100.h,
            ),
            SizedBox(
              width: 40.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edgeText,
              ),
              child: Row(
                children: <Widget>[
                  GWdgtTextTitleDesc(
                      string: getTimeString(),
                      key: ValueKey(widget.serviceCode)),
                ],
              ),
            ),
            CustomDivider(
              height: 100.h,
            ),
            SizedBox(
              width: 40.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edgeText,
              ),
              child: Center(
                child: InkWell(
                    onTap: () async {
                      await removeServiceByCodeAndUpdate(
                          context,
                          widget.serviceCode,
                          widget.serviceRoot,
                          onDeleteServiceSuccess(),
                          onDeleteServiceError(),
                          onDeleteServiceLoad(),
                          onDeleteServiceComplete());
                    },
                    child: AnimatedSwitcher(
                        duration: Duration(milliseconds: durationCalender),
                        child: loading
                            ? Loading()
                            : Icon(CommunityMaterialIcons.delete_circle,
                                color: Colors.white70))),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }

  String getTimeString() {
    return _duration.inHours > 0
        ? ' ${_duration.inHours.toString()}س و ${_duration.inMinutes.remainder(60).toString()} دقيقة'
        : ' ${_duration.inMinutes.remainder(60).toString()} دقيقة';
  }

  Function onDeleteServiceSuccess() {
    return () async {
      showToast(strUpdateDone);
    };
  }

  Function onDeleteServiceError() {
    return () {
      showToast(strUpdateError);
    };
  }

  Function onDeleteServiceLoad() {
    return () async {
      loading = true;
      setState(() {});
    };
  }

  Function onDeleteServiceComplete() {
    return () {
      loading = false;
      setState(() {});
    };
  }
}

///* [String]\

final strMyServices = ' ~ خدماتي ~';
final strMyServicesDesc = '(قائمة خدماتك، ويمكنك حذف الخدمات من هنا)';
final strThereIsNoServices = "لم تقومي بإضافة اي خدمة";
final strUpdateError = 'حدث خطأ اثناء التحديث';
final strUpdateDone = 'تم التحديث بنجاح';

/// [radius]
double radiusContainer = radiusDefault;
double radiusSingleElement = radiusDefault;

///[colors]
Color colorContainerBg = Colors.white38;
Color colorSingleElement = Colors.blue.withOpacity(0.5);

///[edge]
double edgeMainContainer = edgeContainer;
double edgeElementContainer = 8.h;

///[Sizes]
final sizeServiceElement = 120.h;
final sizeElementListContainer = 160.h;
