import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class WdgtSalonMyServices extends StatefulWidget {
  // final Map<String, dynamic> mapServices;
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
    mapServices = Provider.of<VMSalonData>(context).beautyProvider.servicespro;

    return Padding(
      padding: EdgeInsets.all(edgeMainContainer),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: colorContainerBg,
        child: Column(
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
                  allDefaultServicesMap = Provider.of<VMSalonData>(context)
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
                          String itemKey =
                              mapServices['other'].keys.toList()[rowIndex];

                          return SingleService(
                            serviceName: itemKey,
                            prices: mapServices['other'][itemKey],
                            serviceCode: itemKey,
                            serviceRoot: mainServiceKey,
                            // priceBefore: v[0].toString(),
                            // priceAfter: v[1]?.toString() ?? v[0].toString(),
                          );
                        },
                        itemCount: mapServices[mainServiceKey].keys.length,
                      ),
                    );

                  if (allDefaultServicesMap
                      .containsKey(mainServiceKey)) if (allDefaultServicesMap[
                          mainServiceKey]
                      .containsKey(
                          'items')) if (allDefaultServicesMap[mainServiceKey]
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

                          if (allDefaultServicesMap[mainServiceKey]['items']
                              .containsKey(itemKey))
                            return SingleService(
                              serviceName: allDefaultServicesMap[mainServiceKey]
                                      ['items'][itemKey]['ar']
                                  ?.toString(),
                              prices: mapServices[mainServiceKey][itemKey],
                              serviceCode: itemKey,
                              serviceRoot: mainServiceKey,
                              // priceBefore: v[0].toString(),
                              // priceAfter: v[1]?.toString() ?? v[0].toString(),
                            );
                          return SizedBox();
                        },
                        itemCount: mapServices[mainServiceKey].keys.length,
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
      ),
    );
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
    return Padding(
      padding: EdgeInsets.all(edgeElementContainer),
      child: Container(
        height: sizeServiceElement,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSingleElement),
          color: colorSingleElement,
        ),

        // padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GWdgtTextProfile(
                string: widget.serviceName,
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  if (widget.prices.length > 1)
                    GWdgtTextProfile(string: 'قبل: ${widget.prices[1]}   '),
                  GWdgtTextProfile(string: 'السعر: ${widget.prices[0]}   '),
                ],
              ),
            ),
            InkWell(
                onTap: () async {
                  await removeServiceByCodeAndUpdate(
                      context,
                      widget.serviceCode,
                      widget.serviceRoot,
                      onDeleteServiceComplete(),
                      onDeleteServiceError(),
                      onDeleteServiceLoad(),
                      onDeleteServiceSuccess());
                },
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: durationCalender),
                    child: loading
                        ? Loading()
                        : Icon(CommunityMaterialIcons.delete_circle,
                            color: Colors.white70)))
          ],
        ),
      ),
    );
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
const double radiusContainer = 14;
const double radiusSingleElement = 10;

///[colors]
Color colorContainerBg = Colors.white38;
Color colorSingleElement = Colors.blue.withOpacity(0.5);

///[edge]
double edgeMainContainer = 15.h;
double edgeElementContainer = 8.h;

///[Sizes]
final sizeServiceElement = 120.h;
final sizeElementListContainer = 158.h;
