import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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

class WdgtSalonAddService extends StatefulWidget {
  // final Map<String, dynamic> mapServices;
  WdgtSalonAddService({
    Key? key,
  }) : super(key: key);

  @override
  _WdgtSalonAddServiceState createState() => _WdgtSalonAddServiceState();
}

class _WdgtSalonAddServiceState extends State<WdgtSalonAddService> {
  String? value;

  ///list of available services as a widget for the toggleButtons
  List<Widget>? categoryWidgetList;

  double priceBefore = 0;
  double priceAfter = 0;

  ///The 'other' service name
  String otherServiceName = '';

  ///The default service code
  String chosenService = '';

  ///Show price field flag
  bool isShowPrice = true;

  ///Check if toggle buttons list flag;
  bool isToggleButtonsSet = true;
  // bool isMainServiceChosen = false;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  /// * 1- show adding other service
  /// * 2- When adding new service in getNewServiceProvider method it decides
  /// how to serialize data
  bool showOther = false;

  ///This is a list of DropdownMenuItem base on a selected category from the toggleButtons
  ///The default is [] so there is no items in the dropdownMenu
  List<Map<String?, String>> subCategoryList = [];
  TextEditingController durationTextFieldController =
      TextEditingController(text: 'لم يتم التحديد');

  Duration serviceDuration = Duration();
  int serviceDurationInt = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusContainer),
        child: Container(
          padding: EdgeInsets.all(edgeMainContainer),
          color: colorContainerBg,
          // height: ScreenUtil().setHeight(400),
          child: Stack(
            children: [
              Align(
                  child: IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.white24),
                    onPressed: () {},
                  ),
                  alignment: Alignment.topLeft),
              Column(
                children: <Widget>[
                  Y(height: BoxHeight.heightBtwTitle),
                  GWdgtTextTitle(
                    string: strAddingNewService,
                  ),
                  Y(height: BoxHeight.heightBtwContainers),
                  GWdgtTextTitleDesc(string: strAddingNewServiceDetails),

                  Y(height: BoxHeight.heightBtwContainers),
                  if (showOther)
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: BeautyTextfield(
                        onChanged: (str) {
                          otherServiceName = str;
                          isShowPrice = true;
                          setState(() {});
                        },
                        prefixIcon: Icon(
                          CommunityMaterialIcons.ticket,
                          color: AppColors.pinkBright,
                        ),
                        // placeholder: strServiceName,
                        helperText: strServiceName,
                        textStyle: TextStyle(color: AppColors.pinkBright),
                        inputType: TextInputType.text,
                      ),
                    ),
                  Y(),
                  if (isShowPrice)
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: BeautyTextfield(
                        // height: ScreenUtil().setHeight(90),
                        onChanged: (String s) {
                          priceAfter = double.parse(s);
                        },
                        // textStyle: TextStyle(color: AppColors.pinkBright),
                        suffixIcon: Icon(
                          Icons.attach_money,
                        ),
                        helperText: strServicePrice,
                        inputType: TextInputType.number,
                      ),
                    ),
                  Y(),
                  if (isShowPrice)
                    Container(
                      // width: 200.w,
                      child: BeautyTextfield(
                        // prefixText: durationTextFieldController.text,
                        placeholder: durationTextFieldController.text,
                        helperText: 'المدة المتوقعة:  ',
                        readOnly: true,
                        isBox: true,
                        prefixIcon: Icon(CommunityMaterialIcons.watch),
                        onTap: () {
                          late Picker picker;

                          picker = Picker(
                              // backgroundColor: Colors.pink.withOpacity(0.3),
                              adapter: NumberPickerAdapter(
                                  data: <NumberPickerColumn>[
                                    const NumberPickerColumn(
                                        begin: 0,
                                        end: 60,
                                        postfix: GWdgtTextDescDesc(
                                            string: ' دقيقة ',
                                            color: Colors.black),
                                        jump: 15),
                                    const NumberPickerColumn(
                                        begin: 0,
                                        end: 12,
                                        postfix: GWdgtTextDescDesc(
                                            color: Colors.black,
                                            string: ' ساعة '),
                                        columnFlex: 1),
                                  ]),
                              delimiter: <PickerDelimiter>[
                                PickerDelimiter(
                                  child: Container(
                                    width: 30.0.h,
                                    alignment: Alignment.center,
                                    child: Icon(Icons.more_vert),
                                  ),
                                )
                              ],
                              hideHeader: false,
                              confirmTextStyle: TextStyle(
                                  inherit: false,
                                  color: Colors.red,
                                  fontSize: 22),
                              // title: Text(
                              //   'الوقت المتوقع لإنهاء الخدمة',
                              //   textAlign: TextAlign.right,
                              // ),
                              containerColor: Colors.pink,
                              selectedTextStyle: TextStyle(color: Colors.blue),
                              onConfirm: (Picker picker, List<int> value) {
                                // You get your duration here
                                serviceDuration = Duration(
                                    hours: picker.getSelectedValues()[1],
                                    minutes: picker.getSelectedValues()[0]);
                                // picker.doCancel(context);
                                durationTextFieldController.text =
                                    " ${(serviceDuration.inHours).toString()} س ${(serviceDuration.inMinutes.remainder(60) % 60).toString()} د ";
                                // showToast(orderDuration.inMinutes.toString());

                                serviceDurationInt = serviceDuration.inMinutes;
                                setState(() {});
                              },
                              cancel: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  picker.doCancel(context);
                                },
                              ),
                              confirm: IconButton(
                                icon: Icon(
                                  Icons.done,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  picker.doConfirm(context);
                                },
                              ),
                              cancelTextStyle: TextStyle(color: Colors.red),
                              textStyle: TextStyle(color: Colors.blue));
                          picker.showModal(context);
                        },
                        inputType: TextInputType.text,
                      ),
                    ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusButton),
                    child: RoundedLoadingButton(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(radiusButton),
                          ),
                          height: 100,
                          width: double.infinity,
                          child:
                              Center(child: GWdgtTextButton(string: strAdd))),
                      onPressed: () async {
                        if (checkFields()) {
                          await updateProviderServices(
                              context,
                              showOther,
                              chosenService,
                              priceBefore,
                              priceAfter,
                              otherServiceName,
                              serviceDuration.inMinutes,
                              _btnController);
                          clearFields();
                        }

                        _btnController.reset();
                      },
                      controller: _btnController,
                    ),
                  ),
                  Y(
                    height: heightBottomContainer,
                  )

                  // SizedBox(height: ScreenUtil().setHeight(100))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 


  /// When user press on one category [toggleBottons] if not other it will show a list of services
  /// and when press it will save it to [chosenService] variable
  /// [todo]
  void _showPicker() {
    //   PickerController pickerController = PickerController(
    //     count: 1,
    //     // selectedItems: [5, 2, 1],
    //   );

    // //   PickerViewPopup.showMode(
    // //       PickerShowMode.BottomSheet, // AlertDialog or BottomSheet
    // //       controller: pickerController,
    // //       context: context,
    // //       title: GWdgtTextTitleDesc(
    // //         string: strSubcategory,
    // //       ),
    // //       cancel: GWdgtTextPickerCancel(
    // //         string: strCancel,
    // //       ),
    // //       onCancel: () {
    // //         // Scaffold.of(context).showSnackBar(SnackBar(content: Text('AlertDialogPicker.cancel')));
    // //       },
    // //       confirm: GWdgtTextPickerSubmit(
    // //         string: strDone,
    // //       ),
    // //       onConfirm: (controller) {
    // //         var chosen = controller.selectedRowAt(section: 0);
    // //         isShowPrice = true;

    // //         // if (item == 'other') showOther = true;
    // //         chosenService = subCategoryList[chosen].entries.first.value;
    // //         setState(() {
    // //           value = subCategoryList[chosen].entries.first.value;
    // //         });
    // //       },
    // //       builder: (context, popup) {
    // //         return Container(
    // //           height: 150,
    // //           child: popup,
    // //         );
    // //       },
    // //       // itemExtent: 40,
    // //       numberofRowsAtSection: (section) {
    // //         return subCategoryList.length;
    // //       },
    // //       itemBuilder: (section, row) {
    // //         String value = subCategoryList[row].keys.first;
    // //         return GWdgtTextPickerChoices(
    // //           string: value,
    // //         );
    // //       });
  }

  ///Clear all textFields
  clearFields() {
    chosenService = '';
    otherServiceName = '';
  }

  ///This will validate the fields before saving data to database
  bool checkFields() {
    if (showOther) if (otherServiceName == '' || otherServiceName == null) {
      showToast(strValidChooseServiceName);
      return false;
    }
    if (!showOther) if (chosenService == '' || chosenService == null) {
      showToast(strValidChooseService);
      return false;
    }
    if (priceAfter == 0) {
      showToast(strValidPrice);
      return false;
    }
    if (priceBefore != 0 && priceAfter >= priceBefore) {
      showToast(strValidOffer);
      return false;
    }
    if (serviceDurationInt == 0) {
      showToast(strValidDuration);
      return false;
    }
    return true;
  }
}

///This widget represents the toggleButtons item

class WdgtSalonServiceItem extends StatelessWidget {
  final String? serviceName;

  const WdgtSalonServiceItem({Key? key, required this.serviceName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.purpleColor.withOpacity(0.6),
        // width: ScreenUtil().setWidth(100),
        // height: ScreenUtil().setWidth(100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Center(
            child: GWdgtTextToggle(
              string: serviceName,
            ),
          ),
        ));
  }
}

/// if he is valid with this package true else false;
bool checkPackage(Map<String, dynamic> package) {
  if (package['01'] != null) if (DateTime.parse(package['01']['to'])
      .isAfter(DateTime.now().toLocal())) return true;

  return false;
}
