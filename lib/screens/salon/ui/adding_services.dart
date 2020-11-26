import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WdgtSalonAddService extends StatefulWidget {
  final Map<String, dynamic> mapServices;
  WdgtSalonAddService({Key key, this.mapServices}) : super(key: key);

  @override
  _WdgtSalonAddServiceState createState() => _WdgtSalonAddServiceState();
}

class _WdgtSalonAddServiceState extends State<WdgtSalonAddService> {
  String value;

  ///This is a list of bool represents selected category in the toggleButtons
  List<bool> toggleSelectBoolList;
  Map<String, dynamic> mapServices;

  List<Widget> categoryWidgetList;

  ///The index of the category e.g. ['hair','henna'] when user clicks henna the index is 0
  ///So we can get subCategory
  // int indexCategory = 0;
  bool loading = false;
  double priceBefore = 0;
  double priceAfter = 0;
  String otherServiceName = '';
  String chosenService = '';
  bool isShowPrice = false;

  ///Check if toggle buttons list flag;
  bool isToggleButtonsSet = false;

  bool isMainServiceChosen = false;
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  bool showOther = false; //show adding other service

  ///This is a list of DropdownMenuItem base on a selected category from the toggleButtons
  ///The default is [] so there is no items in the dropdownMenu
  List<Map<String, String>> subCategoryList = [];

  setSubCategoryDropdownMenu(int indexCategory) {
    subCategoryList = [];
    if (indexCategory == null) return;
    String categoryKey = widget.mapServices.keys.toList()[indexCategory];
    Map<String, dynamic> allServices = Provider.of<VMSalonData>(context).providedServices['services'];
    widget.mapServices[categoryKey]['items']?.forEach((k, v) {
      subCategoryList.add({allServices[categoryKey]['items'][k]['ar']: '$categoryKey-$k'});
    });
  }

  ///Listen to togglebuttons chosen index and update showing of
  ///other
  otherOptionChosenListener(int indexOfToggleBotton) {
    showOther = false;

    if (indexOfToggleBotton == toggleSelectBoolList.length - 1) {
      showOther = true;
      String msg = "الرجاء التأكد من عدم وجود الخدمة في النموذج، فالخدمات الاخرى لن تكون مشموله بعملية بحث الزبائن";
      showAlert(context, msg: msg, dismiss: 'تم');
    }
  }

  ///Update the toggleButtons bar to show the selected category

  toggleButtonUiUpdater(int indexToggleButton) {
    toggleSelectBoolList = toggleSelectBoolList.map((f) => false).toList();
    isToggleButtonsSet = true;
    toggleSelectBoolList[indexToggleButton] = true;
  }

  @override
  Widget build(BuildContext context) {
    mapServices = Provider.of<VMSalonData>(context).providedServices['services'];
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

              ExtendedText(string: '(يمكنكِ اضافة خدماتك باختيار القسم الرئيسي ثم القسم الفرعي مع اضافة السعر)'),

              SizedBox(height: ScreenUtil().setHeight(30)),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleButtons(
                      children: mapServices.entries
                          .toList()
                          .map((e) => e.value['ar'])
                          .toList()
                          .map((e) => WdgtSalonServiceItem(serviceName: e))
                          .toList(),
                      //Check here togglebutton flag, isselect can't be null, and setting here selectCategory so it is initialized here

                      isSelected: !isToggleButtonsSet
                          ? toggleSelectBoolList = mapServices.entries.toList().map((e) => false).toList()
                          : toggleSelectBoolList,
                      borderRadius: BorderRadius.circular(14),
                      fillColor: Colors.pink,
                      selectedColor: Colors.pink,
                      renderBorder: false,
                      onPressed: (index) {
                        toggleButtonUiUpdater(index);
                        setSubCategoryDropdownMenu(index);
                        otherOptionChosenListener(index);
                        clearFields();
                        _showPicker();

                        if (index == toggleSelectBoolList.length - 1) {
                          isMainServiceChosen = false;
                        } else
                          isMainServiceChosen = true;
                        isShowPrice = false;

                        setState(() {});
                      })),
              SizedBox(height: ScreenUtil().setHeight(15)),

              // if (isMainServiceChosen)
              //   ClipRRect(
              //     borderRadius: BorderRadius.circular(14),
              //     child: Container(
              //       padding: EdgeInsets.only(left: ScreenUtil().setWidth(19), right: ScreenUtil().setWidth(19)),
              //       decoration: BoxDecoration(
              //         color: AppColors.purpleColor,
              //       ),
              //       height: ScreenUtil().setHeight(100),
              //       child: DropdownButton(
              //         items: subCategoryList,

              //         focusColor: AppColors.purpleColor,

              //         elevation: 39,
              //         // autofocus: true,
              //         onChanged: (item) {
              //           isShowPrice = true;
              //           // if (item == 'other') showOther = true;
              //           chosenService = item;
              //           setState(() {
              //             value = item;
              //           });

              //           // newMap[item.split('-')[0]] = item.split('-')[1];
              //         },
              //         // elevation: 20,
              //         // isDense: true,
              //         // selectedItemBuilder: (context) {
              //         //   return [];
              //         // },
              //         value: value,
              //         hint: ExtendedText(string: 'اختاري الخدمة'),
              //         // elevation: 40,
              //         style: TextStyle(
              //           color: AppColors.pinkBright,
              //         ),
              //         icon: Icon(CommunityMaterialIcons.arrow_down_drop_circle),
              //         isExpanded: true,

              //         underline: Text(''),
              //       ),
              //     ),
              //   ),
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
              //     Consumer<VMSalonData>(builder: (_, VMSalonData, child) {
              //       return BeautyTextfieldT(
              //         width: ScreenUtil().setWidth(343),
              //         height: ScreenUtil().setHeight(90),
              //         prefixIcon: Icon(
              //           Icons.money_off,
              //           color: AppColors.pinkBright,
              //         ),
              //         enabled: checkPackage(VMSalonData.beautyProvider.package),
              //         onChanged: (String s) {
              //           priceBefore = double.parse(s);
              //         },
              //         placeholder:
              //             checkPackage(VMSalonData.beautyProvider.package)
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

                      ModelBeautyProvider bp = await sharedUserProviderGetInfo();
                      try {
                        Provider.of<VMSalonData>(context).beautyProvider = await apiBeautyProviderUpdate(bp..servicespro = getNewMap());
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

                      clearFields();
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

  void _showPicker() {
    PickerController pickerController = PickerController(
      count: 1,
      // selectedItems: [5, 2, 1],
    );

    PickerViewPopup.showMode(PickerShowMode.BottomSheet, // AlertDialog or BottomSheet
        controller: pickerController,
        context: context,
        title: Text(
          'فرعيات الخدمة',
          style: TextStyle(fontSize: 14),
        ),
        cancel: Text(
          'cancel',
          style: TextStyle(color: Colors.grey),
        ),
        onCancel: () {
          // Scaffold.of(context).showSnackBar(SnackBar(content: Text('AlertDialogPicker.cancel')));
        },
        confirm: Text(
          'confirm',
          style: TextStyle(color: Colors.blue),
        ),
        onConfirm: (controller) {
          var chosen = controller.selectedRowAt(section: 0);
          isShowPrice = true;

          // if (item == 'other') showOther = true;
          chosenService = subCategoryList[chosen].entries.first.value;
          setState(() {
            value = subCategoryList[chosen].entries.first.value;
          });

          // newMap[item.split('-')[0]] = item.split('-')[1];
          // List<int> selectedItems = [];
          // selectedItems.add(controller.selectedRowAt(section: 0));
          // selectedItems.add(controller.selectedRowAt(section: 1));
          // selectedItems.add(controller.selectedRowAt(section: 2));

          // Scaffold.of(context).showSnackBar(SnackBar(content: Text('AlertDialogPicker.selected:$selectedItems')));
        },
        builder: (context, popup) {
          return Container(
            height: 150,
            child: popup,
          );
        },
        itemExtent: 40,
        numberofRowsAtSection: (section) {
          return 10;
        },
        itemBuilder: (section, row) {
          return Text(
            subCategoryList[row].entries.first.key,
            style: TextStyle(fontSize: 12),
          );
        });
  }

  Map<String, dynamic> getNewMap() {
    ModelBeautyProvider beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
    Map<String, dynamic> map = new Map<String, dynamic>.of(beautyProvider.servicespro);
    Map<String, dynamic> newMap = copyDeepMap(map);

    if (!showOther) {
      List<String> services = chosenService.split('-');
      List<double> numbers = priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];

      if (newMap[services[0]] == null)
        newMap[services[0]] = {services[1]: numbers};
      else
        newMap[services[0]][services[1]] = numbers;
    } else {
      if (newMap['other'] == null)
        newMap['other'] = {
          otherServiceName: priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore]
        };
      else
        newMap['other'][otherServiceName] = priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];
    }
    return newMap;
  }

  ///Clear all textFields
  clearFields() {
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
  if (package['01'] != null) if (DateTime.parse(package['01']['to']).isAfter(DateTime.now().toLocal())) return true;

  return false;
}

Map<String, dynamic> copyDeepMap(Map<String, dynamic> map) {
  Map<String, dynamic> newMap = {};

  map.forEach((key, value) {
    newMap[key] = (value is Map) ? copyDeepMap(value) : value;
  });

  return newMap;
}

class WdgtSalonServiceItem extends StatelessWidget {
  final String serviceName;

  const WdgtSalonServiceItem({Key key, @required this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.purpleColor.withOpacity(0.6),
        width: ScreenUtil().setWidth(100),
        height: ScreenUtil().setWidth(100),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ExtendedText(
              string: serviceName,
              fontSize: ExtendedText.bigFont,
            ),
          ),
        ));
  }
}
