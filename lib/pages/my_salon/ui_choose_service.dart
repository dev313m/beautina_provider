import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/pages/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/pages/root/shared_variable_root.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:spring_button/spring_button.dart';

class WidgetAddService extends StatefulWidget {
  final Map<String, dynamic> mapServices;
  WidgetAddService({Key key, this.mapServices}) : super(key: key);

  @override
  _WidgetAddServiceState createState() => _WidgetAddServiceState();
}

class _WidgetAddServiceState extends State<WidgetAddService> {
  String value;
  List<bool> selectedCategory;

  List<Widget> categoryWidgetList;
  int indexCategory = 0;
  bool loading = false;
  double priceBefore = 0;
  double priceAfter = 0;
  String otherServiceName = '';
  String chosenService = '';
  bool isShowPrice = false;

  bool isMainServiceChosen = false;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  bool showOther = false; //show adding other service
  List<DropdownMenuItem> subCategoryList = [];
  // Map<int,String> categoryMapper={};

  iniSubCategory() {
    value = null;
    subCategoryList = [];

    if (indexCategory == null) return;
    String categoryKey = widget.mapServices.keys.toList()[indexCategory];
    Map<String, dynamic> allServices =
        Provider.of<SharedSalon>(context).providedServices['services'];
    widget.mapServices[categoryKey]['items']?.forEach((k, v) {
      subCategoryList.add(DropdownMenuItem(
        child: Text(allServices[categoryKey]['items'][k]['ar']),
        value: '$categoryKey-$k',
      ));
    });
  }

  // iniSubCategoryMapper(){
  //   int index = 0;
  //   widget.mapServices.forEach((k, v) {

  //     categoryMapper[index]  = k;

  //   });
  //   return subCategoryList;

  // }

  categoryItems() {
    categoryWidgetList = [];
    selectedCategory = [];

    widget.mapServices.forEach((k, v) {
      categoryWidgetList.add(
        Container(
            color: AppColors.purpleColor.withOpacity(0.6),
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setWidth(100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ExtendedText(
                  string: v['ar'],
                  fontSize: ExtendedText.bigFont,
                ),
              ),
            )),
      );
      selectedCategory.add(false);
    });
    selectedCategory[0] = false;
  }

  @override
  void initState() {
    super.initState();
    categoryItems();
    // iniSubCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
          color: Colors.white38,
          // height: ScreenUtil().setHeight(400),
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(30)),
              ExtendedText(
                string: '~ اضافة الخدمات ~',
                fontSize: ExtendedText.xbigFont,
              ),
              SizedBox(height: ScreenUtil().setHeight(30.h)),

              ExtendedText(
                  string:
                      '(يمكنكِ اضافة خدماتك باختيار القسم الرئيسي ثم القسم الفرعي مع اضافة السعر)'),

              SizedBox(height: ScreenUtil().setHeight(30)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<SharedSalon>(builder: (_, sharedSalon, child) {
                  // iniSubCategory();
                  return ToggleButtons(
                      children: categoryWidgetList,
                      isSelected: selectedCategory,
                      borderRadius: BorderRadius.circular(14),
                      fillColor: Colors.pink,
                      selectedColor: Colors.pink,
                      renderBorder: false,
                      onPressed: (index) {
                        indexCategory = index;
                        selectedCategory =
                            selectedCategory.map((f) => false).toList();
                        iniSubCategory();
                        selectedCategory[index] = true;
                        showOther = false;

                        chosenService = '';
                        otherServiceName = '';

                        if (index == selectedCategory.length - 1) {
                          showOther = true;
                          String msg =
                              "الرجاء التأكد من عدم وجود الخدمة في النموذج، فالخدمات الاخرى لن تكون مشموله بعملية بحث الزبائن";

                          showAlert(context, msg: msg, dismiss: 'تم');
                        }

                        if (index == selectedCategory.length - 1) {
                          isMainServiceChosen = false;
                        } else
                          isMainServiceChosen = true;
                        isShowPrice = false;

                        setState(() {});
                      });
                }),
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),

              if (isMainServiceChosen)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(19),
                        right: ScreenUtil().setWidth(19)),
                    decoration: BoxDecoration(
                      color: AppColors.purpleColor,
                    ),
                    height: ScreenUtil().setHeight(100),
                    child: DropdownButton(
                      items: subCategoryList,

                      focusColor: AppColors.purpleColor,

                      elevation: 39,
                      // autofocus: true,
                      onChanged: (item) {
                        isShowPrice = true;
                        // if (item == 'other') showOther = true;
                        chosenService = item;
                        setState(() {
                          value = item;
                        });

                        // newMap[item.split('-')[0]] = item.split('-')[1];
                      },
                      // elevation: 20,
                      // isDense: true,
                      // selectedItemBuilder: (context) {
                      //   return [];
                      // },
                      value: value,
                      hint: ExtendedText(string: 'اختاري الخدمة'),
                      // elevation: 40,
                      style: TextStyle(
                        color: AppColors.pinkBright,
                      ),
                      icon: Icon(CommunityMaterialIcons.arrow_down_drop_circle),
                      isExpanded: true,

                      underline: Text(''),
                    ),
                  ),
                ),
              if (showOther)
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: BeautyTextfieldT(
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setHeight(100),
                    onChanged: (str) {
                      otherServiceName = str;
                      isShowPrice = true;
                      setState(() {});
                    },
                    prefixIcon: Icon(
                      CommunityMaterialIcons.ticket,
                      color: AppColors.pinkBright,
                    ),
                    placeholder: 'اسم الخدمة',
                    textStyle: TextStyle(color: AppColors.pinkBright),
                    inputType: TextInputType.text,
                  ),
                ),
              SizedBox(height: ScreenUtil().setHeight(17)),

              if (isShowPrice)
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: BeautyTextfieldT(
                    width: ScreenUtil().setHeight(200),
                    height: ScreenUtil().setHeight(90),
                    onChanged: (String s) {
                      priceAfter = double.parse(s);
                    },
                    textStyle: TextStyle(color: AppColors.pinkBright),
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: AppColors.pinkBright,
                    ),
                    placeholder: 'السعر',
                    onSubmitted: (tex) {},
                    inputType: TextInputType.number,
                  ),
                ),

              SizedBox(height: ScreenUtil().setHeight(17)),
              // Row(
              //   children: <Widget>[
              //      Directionality(
              //         textDirection: TextDirection.rtl,
              //         child: BeautyTextfieldT(
              //           width: ScreenUtil().setHeight(200),
              //           height: ScreenUtil().setHeight(90),
              //           onChanged: (String s) {
              //             priceAfter = double.parse(s);
              //           },
              //           prefixIcon: Icon(
              //             Icons.attach_money,
              //             color: AppColors.pinkBright,
              //           ),
              //           placeholder: 'السعر',
              //           inputType: TextInputType.number,
              //         ),
              //       ),

              //     SizedBox(width: ScreenUtil().setWidth(17)),
              //     Consumer<SharedSalon>(builder: (_, sharedSalon, child) {
              //       return BeautyTextfieldT(
              //         width: ScreenUtil().setWidth(343),
              //         height: ScreenUtil().setHeight(90),
              //         prefixIcon: Icon(
              //           Icons.money_off,
              //           color: AppColors.pinkBright,
              //         ),
              //         enabled: checkPackage(sharedSalon.beautyProvider.package),
              //         onChanged: (String s) {
              //           priceBefore = double.parse(s);
              //         },
              //         placeholder:
              //             checkPackage(sharedSalon.beautyProvider.package)
              //                 ? 'السعر قبل العرض'
              //                 : "السعر قبل (يجب تفعيل الباقة)",
              //         inputType: TextInputType.number,
              //       );
              //     }),
              //   ],
              // ),
              SizedBox(height: ScreenUtil().setHeight(17)),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: RoundedLoadingButton(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      height: 58,
                      width: double.infinity,
                      child: Center(child: ExtendedText(string: 'اضافة'))),
                  onPressed: () async {
                    /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */
                    if (checkFields()) {
                      _btnController.start();

                      ModelBeautyProvider bp =
                          await sharedUserProviderGetInfo();
                      try {
                        Provider.of<SharedSalon>(context).beautyProvider =
                            await apiBeautyProviderUpdate(
                                bp..servicespro = getNewMap());
                        // setState(() {});
                        showToast('تمت الاضافة بنجاح');
                        _btnController.success();
                        await Future.delayed(Duration(seconds: 3));
                        _btnController.reset();
                      } catch (e) {
                        showToast('حدث خطأ، لم يتم الاضافة');
                        _btnController.error();
                        await Future.delayed(Duration(seconds: 3));
                        _btnController.reset();
                      }

                      resetFields();
                    }
                    _btnController.reset();
                  },
                  controller: _btnController,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(100))
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> getNewMap() {
    ModelBeautyProvider beautyProvider =
        Provider.of<SharedSalon>(context).beautyProvider;
    Map<String, dynamic> map =
        new Map<String, dynamic>.of(beautyProvider.servicespro);
    Map<String, dynamic> newMap = copyDeepMap(map);

    if (!showOther) {
      List<String> services = chosenService.split('-');
      List<double> numbers =
          priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];

      if (newMap[services[0]] == null)
        newMap[services[0]] = {services[1]: numbers};
      else
        newMap[services[0]][services[1]] = numbers;
    } else {
      if (newMap['other'] == null)
        newMap['other'] = {
          otherServiceName:
              priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore]
        };
      else
        newMap['other'][otherServiceName] =
            priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];
    }
    return newMap;
  }

  resetFields() {
    chosenService = '';
    otherServiceName = '';
  }

  bool checkFields() {
    if (showOther) if (otherServiceName == '' || otherServiceName == null) {
      showToast('يجب اختيار اسم الخدمة');
      return false;
    }
    if (!showOther) if (chosenService == '' || chosenService == null) {
      showToast('يجب اختيار خدمة');
      return false;
    }
    if (priceAfter == 0) {
      showToast('يجب وضع ملبغ الخدمة');
      return false;
    }
    if (priceBefore != 0 && priceAfter >= priceBefore) {
      showToast('سعر العرض يجب ان يكون اقل من سعر قبل العرض');
      return false;
    }
    return true;
  }
}

/// if he is valid with this package true else false;
bool checkPackage(Map<String, dynamic> package) {
  if (package['01'] != null) if (DateTime.parse(package['01']['to'])
      .isAfter(DateTime.now().toLocal())) return true;

  return false;
}

Map<String, dynamic> copyDeepMap(Map<String, dynamic> map) {
  Map<String, dynamic> newMap = {};

  map.forEach((key, value) {
    newMap[key] = (value is Map) ? copyDeepMap(value) : value;
  });

  return newMap;
}
