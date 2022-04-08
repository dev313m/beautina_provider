import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/utils/animated/loading.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

/// [radius]
double radiusButton = radiusDefault;
double radiusContainer = radiusDefault;

///[edge]
double edgeMainContainer = edgeContainer;
double edgeMainText = 8.h;

///[colors]
Color colorContainerBg = Colors.white38;
Color colorSubmitButton = Colors.blue;
Color colorTitleFont = Colors.white;
Color colorToggle = Colors.black;
Color colorToggleSplash = Colors.black;

///[Strings]
final strAddingNewService = '~ إضافة الخدمات ~';
final strAddingNewServiceDetails =
    '(يمكنكِ اضافة خدماتك باختيار القسم الرئيسي ثم القسم الفرعي مع اضافة السعر)';
final strServiceName = 'اسم الخدمة';
final strServicePrice = 'السعر';
final strAddingOtherAlert =
    "الرجاء التأكد من عدم وجود الخدمة في النموذج، فالخدمات الاخرى لن تكون مشموله بعملية بحث الزبائن";
final strAdd = 'إضافة';
final strDone = 'تم';
final strSubcategory = 'فرعيات الخدمة';
final strCancel = 'عودة';
final strValidChooseServiceName = 'يجب اختيار اسم الخدمة';
final strValidChooseService = 'يجب اختيار خدمة';
final strValidPrice = 'يجب وضع ملبغ الخدمة';
final strValidOffer = 'سعر العرض يجب ان يكون اقل من سعر قبل العرض';
final strValidDuration = "يجب ادخال المدة المتوقعة لعمل الخدمة";

class WdgtSalonDefaultAccept extends StatefulWidget {
  WdgtSalonDefaultAccept({Key? key}) : super(key: key);

  @override
  _WdgtSalonDefaultAcceptState createState() => _WdgtSalonDefaultAcceptState();
}

class _WdgtSalonDefaultAcceptState extends State<WdgtSalonDefaultAccept> {
  ///Show loading animation when updating flag
  bool availableLoad = false;

  late ModelBeautyProvider beautyProvider;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VMSalonDataTest>(builder: (vMSalonData) {
      beautyProvider = vMSalonData.beautyProvider;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(edgeMainContainer),
              // height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
              decoration: BoxDecoration(
                  color: colorContainerBg,
                  borderRadius: BorderRadius.circular(radiusContainer)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Y(
                    height: heightBottomContainer,
                  ),
                  Center(
                      child: GWdgtTextTitle(
                    string: 'الاعدادات الافتراضية لقبول الطلبات',
                  )),
                  Y(),
                  GWdgtTextTitleDesc(
                    string:
                        'من هنا يمكنك وضع اعدادات افتراضيه للطلبات القادمه مما يحسن تفاعل زبائنك وراحتك',
                  ),
                  Y(
                    height: heightBottomContainer,
                  ),
                  Container(
                    height: 400.h,
                    child: FlareActor(
                      'assets/rive/rocket.flr',
                      animation: 'untitled',
                      shouldClip: false,
                      snapToEnd: false,
                      // controller: ,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Y(
                            height: heightBottomContainer,
                          ),
                          Center(
                              child: GWdgtTextTitleDesc(
                                  string: 'تفعيل القبول الذاتي للطلبات؟',
                                  textAlign: TextAlign.left,
                                  color: Colors.white)),
                          Y(),
                          GWdgtTextDescDesc(
                            string:
                                'اي طلب يآتي في وقت غير محجور سيُقبل تلفائيا',
                          ),
                          Y(
                            height: heightBottomContainer,
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      availableLoad
                          ? GetLoadingWidget()
                          : ToggleButtons(
                              borderRadius:
                                  BorderRadius.circular(radiusDefault),
                              isSelected: [
                                beautyProvider.default_accept!,
                                !beautyProvider.default_accept!
                              ],
                              onPressed: (values) {
                                bool chosed;
                                if (values == 1)
                                  chosed = false;
                                else
                                  chosed = true;
                                updateUserDefaults(
                                    context,
                                    onAvailableChangeSuccess(),
                                    onAvailableChangeLoad(),
                                    onAvailableChangeError(),
                                    onAvailableChangeComplete(),
                                    defaultAccept: chosed,
                                    defaultAfterAccept:
                                        beautyProvider.default_after_accept);
                              },
                              selectedColor: Colors.blue,
                              fillColor: Colors.blue,
                              // selectedBorderColor: Colors.white,
                              color: Colors.pink,

                              children: [
                                Container(
                                  child: GWdgtTextTitleDesc(
                                    string: 'نعم',
                                  ),
                                ),
                                Container(
                                  child: GWdgtTextTitleDesc(
                                    string: 'لا',
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Y(),
                          Center(
                              child: GWdgtTextTitleDesc(
                                  string: 'منع تكرار الحجر في نفس الوقت',
                                  textAlign: TextAlign.left,
                                  color: Colors.white)),
                          Y(),
                          GWdgtTextDescDesc(
                            string:
                                'لن يتمكن زبائنك من حجز موعد في حالة وجود موعد آخر',
                          ),
                          Y(
                            height: heightBottomContainer,
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      availableLoad
                          ? GetLoadingWidget()
                          : ToggleButtons(
                              borderRadius:
                                  BorderRadius.circular(radiusDefault),
                              isSelected:
                                  beautyProvider.default_after_accept == 1
                                      ? [false , true]
                                      : [true, false],
                              onPressed: (values) {
                                int chosed;
                                if (values == 1)
                                  chosed = 1;
                                else
                                  chosed = 2;
                                updateUserDefaults(
                                    context,
                                    onAvailableChangeSuccess(),
                                    onAvailableChangeLoad(),
                                    onAvailableChangeError(),
                                    onAvailableChangeComplete(),
                                    defaultAccept:
                                        beautyProvider.default_accept,
                                    defaultAfterAccept: chosed);
                              },
                              selectedColor: Colors.blue,
                              fillColor: Colors.blue,
                              // selectedBorderColor: Colors.white,
                              color: Colors.pink,

                              children: [
                                Container(
                                  child: GWdgtTextDescDesc(
                                    string: 'نعم',
                                  ),
                                ),
                                Container(
                                  child: GWdgtTextDescDesc(
                                    string: 'لا',
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Y(
              height: heightBottomContainer,
            )
          ],
        ),
      );
    });
  }

  Function onAvailableChangeComplete() {
    return () {
      availableLoad = false;
      setState(() {});
    };
  }

  Function onAvailableChangeError() {
    return () {
      showToast('strUpdateError');
    };
  }

  Function onAvailableChangeLoad() {
    return () async {
      availableLoad = true;
      setState(() {});
    };
  }

  Function onAvailableChangeSuccess() {
    return () {
      availableLoad = false;
    };
  }
}
