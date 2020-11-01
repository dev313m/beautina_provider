import 'dart:convert';
import 'dart:io';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/screens/my_salon/beauty_provider_page/functions.dart';
import 'package:beautina_provider/screens/my_salon/index.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';

import 'package:beautina_provider/screens/settings/functions.dart';

import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/picker.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/painting.dart' as painting;

import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/services/api/image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PageSettings extends StatefulWidget {
  PageSettings({Key key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();
  bool _autoValidate = false;
  String _name;
  String _email;
  String _description;
  String _city;
  String _country;
  List<dynamic> _location;
  String _mobile;
  ScrollController _scrollController;
  double currentScroll = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();

    // _animationController.dispose();
  }

  String introLocationStr = 'اختيار الخريطة (الرجاء تفعيل الخرائط)';
  bool loadingLocation = false;
  bool imageLoad = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse)
        Provider.of<VMRootUi>(context).hideBars = true;
      else if (Provider.of<VMRootUi>(context).hideBars)
        Provider.of<VMRootUi>(context).hideBars = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedSalon>(builder: (_, sharedOrder, child) {
      ModelBeautyProvider beautyProvider = sharedOrder.beautyProvider;
      return Scaffold(
        key: _globalKey,
        backgroundColor: Colors.transparent,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: ScreenUtil().setHeight(200)),
                        ExtendedText(
                            string: 'تعديل الصورة الشخصية',
                            fontSize: ExtendedText.xbigFont),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        InkWell(
                          onTap: () async {
                            File file = await imageChoose();
                            if (await file.exists() == false) return;
                            // painting.imageCache.clear();
                            DefaultCacheManager manager =
                                new DefaultCacheManager();
                            manager.emptyCache();
                            imageLoad = true;
                            setState(() {});
                            bool response =
                                await imageUpload(file, beautyProvider.uid);
                            if (response) {
                              try {
                                // imageCache.clear();
                                // painting.imageCache.clear();
                                DefaultCacheManager manager =
                                    new DefaultCacheManager();
                                manager.emptyCache();
                                await Future.delayed(Duration(seconds: 8));
                                // super.setState(() {});
                                setState(() {});
                              } catch (e) {
                                showToast('حدث خطأ في التحديث ${e.toString()}');
                              }
                              imageLoad = false;
                            }
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(399),
                            width: ScreenUtil().setHeight(399),
                            child: ClipOval(
                                key: Key('ovalkey'),
                                // clipper: ,
                                // height: ScreenUtil().setHeight(300),
                                child: AnimatedSwitcher(
                                    duration: Duration(seconds: 1),
                                    child: imageLoad
                                        ? Loading()
                                        : Stack(
                                            children: <Widget>[
                                              MyImage(
                                                key: ValueKey('imagelk'),
                                                url:
                                                    'https://resorthome.000webhostapp.com/upload/${beautyProvider.uid}.jpg',
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Icon(
                                                  CommunityMaterialIcons
                                                      .folder_edit,
                                                  color: Colors.deepOrange,
                                                  size: ScreenUtil().setSp(80),
                                                ),
                                              )
                                            ],
                                          ))),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(50)),
                        Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Colors.white24),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autoValidate,
                            child: Column(children: [
                              Icon(CommunityMaterialIcons.account_edit,
                                  color: AppColors.pinkBright,
                                  size: ScreenUtil().setHeight(200)),
                              ExtendedText(
                                  string: 'البيانات الشخصية',
                                  fontSize: ExtendedText.xbigFont),
                              SizedBox(height: ScreenUtil().setHeight(40)),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    // hintText: 'الاسم',
                                    prefixText: 'الاسم: ',
                                    prefixStyle:
                                        TextStyle(color: AppColors.blueOpcity),
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(9.0),
                                      ),
                                      // gapPadding: ScreenUtil().setWidth(20)
                                    ),
                                    suffix: Icon(
                                        CommunityMaterialIcons.face_profile),
                                    // labelText: 'الاسم',
                                    filled: true,
                                    hasFloatingPlaceholder: true,
                                    // helperText: beautyProvider.name,
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[800]),
                                    fillColor: Colors.white70),
                                keyboardType: TextInputType.text,
                                validator: validateName,
                                onSaved: (String val) {
                                  _name = val;
                                },
                                initialValue: beautyProvider.name,
                              ),
                              SizedBox(height: ScreenUtil().setHeight(8)),
                              new TextFormField(
                                initialValue: beautyProvider.username.substring(
                                    4, beautyProvider.username.length),
                                decoration: new InputDecoration(
                                    suffixText: '966 ',
                                    prefixStyle:
                                        TextStyle(color: AppColors.blueOpcity),
                                    hasFloatingPlaceholder: true,
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      gapPadding: ScreenUtil().setWidth(20),
                                    ),
                                    prefixIcon:
                                        Icon(CommunityMaterialIcons.phone),
                                    filled: true,
                                    // labelText: '966',
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[800]),
                                    hintText: "رقم الجوال",
                                    fillColor: Colors.white70),
                                // strutStyle: StrutStyle(/),
                                keyboardType: TextInputType.phone,
                                validator: validateMobile,
                                onSaved: (String val) {
                                  _mobile = Countries.phoneCodePlus[
                                          beautyProvider.country] +
                                      val;
                                },
                              ),
                              SizedBox(height: ScreenUtil().setHeight(8)),
                              new TextFormField(
                                initialValue: beautyProvider.intro,
                                minLines: 3,
                                maxLines: 5,
                                decoration: new InputDecoration(
                                    prefixText: 'وصف مختصر:',
                                    prefixStyle:
                                        TextStyle(color: AppColors.blueOpcity),
                                    hasFloatingPlaceholder: true,
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                        CommunityMaterialIcons.information),
                                    filled: true,
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[800]),
                                    // hintText: "وصف للصالون مختصر",
                                    fillColor: Colors.white70),
                                keyboardType: TextInputType.text,
                                validator: validateName,
                                onSaved: (String val) {
                                  _description = val;
                                },
                              ),
                              new SizedBox(
                                height: ScreenUtil().setWidth(10),
                              ),
                              RoundedLoadingButton(
                                controller: _controller,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: ExtendedText(
                                          string: 'تحديث',
                                          fontSize: ExtendedText.bigFont,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await updateBtn();
                                },
                                color: Colors.blue,
                                animateOnTap: false,
                              )
                            ]),
                          ),
                        ),
                        new SizedBox(
                          height: ScreenUtil().setWidth(100),
                        ),
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Colors.white24),
                            child: Column(
                              children: <Widget>[
                                Icon(CommunityMaterialIcons.map_marker_check,
                                    color: AppColors.pinkBright,
                                    size: ScreenUtil().setHeight(200)),
                                ExtendedText(
                                    string: 'بيانات الموقع',
                                    fontSize: ExtendedText.xbigFont),
                                SizedBox(
                                  height: ScreenUtil().setHeight(40),
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Container(
                                      child: Material(
                                        color: AppColors.pinkBright,
                                        child: Ink(
                                            height: ScreenUtil().setHeight(100),
                                            child: InkWell(
                                              splashColor: Colors.pink,
                                              focusColor: Colors.pink,
                                              hoverColor: Colors.pink,
                                              highlightColor: Colors.pink,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenUtil()
                                                            .setWidth(8)),
                                                    child: Icon(Icons.home),
                                                  ),
                                                  ExtendedText(
                                                    string: 'اختيار المنطقة',
                                                    fontColor: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                showMenuLocation(
                                                    context, _globalKey);
                                              },
                                            )),
                                      ),
                                    )),
                                Row(
                                  children: <Widget>[
                                    Chip(
                                        label: ExtendedText(
                                      string: _city == null
                                          ? beautyProvider.city
                                          : _country,
                                      fontColor: Colors.black,
                                    )),
                                    Chip(
                                        label: ExtendedText(
                                      string: _country == null
                                          ? beautyProvider.country
                                          : _city,
                                      fontColor: Colors.black,
                                    ))
                                  ],
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Container(
                                      child: Material(
                                        color: AppColors.pinkBright,
                                        child: Ink(
                                            height: ScreenUtil().setHeight(100),
                                            child: InkWell(
                                              splashColor: Colors.pink,
                                              focusColor: Colors.pink,
                                              hoverColor: Colors.pink,
                                              highlightColor: Colors.pink,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenUtil()
                                                            .setWidth(8)),
                                                    child:
                                                        Icon(Icons.location_on),
                                                  ),
                                                  loadingLocation
                                                      ? Loading()
                                                      : ExtendedText(
                                                          string:
                                                              introLocationStr,
                                                          fontColor:
                                                              Colors.black,
                                                        ),
                                                ],
                                              ),
                                              onTap: () async {
                                                setState(() {
                                                  loadingLocation = true;
                                                });
                                                List<dynamic> location =
                                                    await getMyLocation();
                                                setState(() {
                                                  loadingLocation = false;
                                                  if (loadingLocation == null)
                                                    introLocationStr =
                                                        'حدث خطأ ما، الرجاء تفعيل تحديد الموقع';
                                                  else {
                                                    introLocationStr =
                                                        "تمت الاضافة ";
                                                    _location = location;
                                                  }
                                                });
                                              },
                                            )),
                                      ),
                                    )),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                RoundedLoadingButton(
                                  controller: _controller,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Center(
                                          child: ExtendedText(
                                            string: 'تحديث',
                                            fontSize: ExtendedText.bigFont,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await updateBtn();
                                  },
                                  color: Colors.blue,
                                  animateOnTap: false,
                                )
                              ],
                            )),
                        new SizedBox(
                          height: ScreenUtil().setWidth(100),
                        ),
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setWidth(30)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Colors.white24),
                            child: Column(
                              children: <Widget>[
                                ExtendedText(
                                  string: "للشكوى والاقتراحات والاستفسارات",
                                  fontSize: ExtendedText.xxbigFont,
                                ),
                                SizedBox(height: ScreenUtil().setHeight(100)),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        child: Icon(
                                          CommunityMaterialIcons.whatsapp,
                                          size: ScreenUtil().setSp(150),
                                          color: Colors.green,
                                        ),
                                        onTap: () {
                                          try {
                                            getWhatsappFunction(
                                                '+966581375460')();
                                          } catch (e) {}
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Icon(
                                          CommunityMaterialIcons.telegram,
                                          size: ScreenUtil().setSp(150),
                                          color: Colors.blue,
                                        ),
                                        onTap: () {
                                          try {
                                            urlLaunch(
                                                url: 'https://t.me/beautinapp');
                                          } catch (e) {}
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Icon(
                                          CommunityMaterialIcons.instagram,
                                          size: ScreenUtil().setSp(150),
                                          color: Colors.redAccent,
                                        ),
                                        onTap: () {
                                          try {
                                            urlLaunch(
                                                url:
                                                    'https://www.instagram.com/beautina.app');
                                          } catch (e) {}
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        new SizedBox(
                          height: ScreenUtil().setWidth(100),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future updateBtn() async {
    if (!_validateInputs()) return;
    /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */

    //2
    ModelBeautyProvider newBeautyProvider = await getNewBeauty();

    try {
      _controller.start();
      // setState(() {});
      Provider.of<SharedSalon>(context).beautyProvider =
          await apiBeautyProviderUpdate(newBeautyProvider);
      showToast('تم التحديث');
      _controller.success();
    } catch (e) {
      showToast('حدثت مشكلة، لم يتم التحديث');
      _controller.error();
    }
    await Future.delayed(Duration(seconds: 3));
    _controller.reset();
    return;
  }

  Future<ModelBeautyProvider> getNewBeauty() async {
    ModelBeautyProvider bp = await sharedUserProviderGetInfo();

    bp.name = _name ?? bp.name;
    bp.username = _mobile ?? bp.username;
    bp.intro = _description ?? bp.intro;
    bp.location = _location ?? bp.location;
    bp.city = _city ?? bp.city;
    bp.country = _country ?? bp.country;

    return bp;
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 9)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  bool _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      return true;
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
      return false;
    }
  }

  showMenuLocation(
      BuildContext context, GlobalKey<State<StatefulWidget>> globalKey) {
    Function onConfirm() {
      return (Picker picker, List value) {
        // Provider.of<SignInSharedVariable>(context).city =
        //     picker.adapter.getSelectedValues();
        // picker.getSelectedValues();

        _country = Countries.countriesMap['السعوديه'];
        // _country =
        //     Countries.countriesMap[picker.adapter.getSelectedValues()[0]];
        _city = Countries
            .citiesMap[picker.adapter.getSelectedValues().elementAt(0)];
        setState(() {});
        // print(picker.getSelectedValues().toString());
      };
    }

    cityPicker(onConfirm: onConfirm(), context: context);

    // Picker picker = Picker(
    //     adapter: PickerDataAdapter<String>(
    //         pickerdata: JsonDecoder().convert(Countries.countriesList)),
    //     changeToFirst: true,
    //     textAlign: TextAlign.left,
    //     cancelText: 'عودة',
    //     confirmText: 'تأكيد',
    //     textStyle: const TextStyle(color: Colors.blue),
    //     selectedTextStyle: TextStyle(color: Colors.red),
    //     columnPadding: EdgeInsets.all(ScreenUtil().setWidth(8)),
    //     onConfirm: (Picker picker, List value) {
    //       // Provider.of<SignInSharedVariable>(context).city =
    //       //     picker.adapter.getSelectedValues();
    //       // picker.getSelectedValues();

    //       _country =
    //           Countries.countriesMap[picker.adapter.getSelectedValues()[0]];
    //       _city = Countries.citiesMap[picker.adapter.getSelectedValues()[1]];
    //       print(picker.getSelectedValues().toString());
    //     });
    // picker.show(globalKey.currentState);
  }
}
