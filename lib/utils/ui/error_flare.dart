import 'package:beautina_provider/constants/app_colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetOnErrorWidget extends StatefulWidget {
  final Function? onTap;
  const GetOnErrorWidget({this.onTap});
  @override
  _GetOnErrorWidgetState createState() => _GetOnErrorWidgetState();
}

class _GetOnErrorWidgetState extends State<GetOnErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,

      // width: double.infinity,
      height: ScreenUtil().setHeight(400),
      child: Stack(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(400),
            child: FlareActor(
              "assets/rive/internet.flr",

              // shouldClip: true,
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fitHeight,
              // sizeFromArtboard: false,
              animation: 'init',
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:  EdgeInsets.only(bottom: 40.h, right: 60.w),
              child: InkWell(
                onTap: () {
                  widget.onTap!();
                },
                // padding:
                //     EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                // textColor: Colors.pink,

                child: Image.asset(
                  'assets/images/reload.png',
                  height: 70.h,
                  color: AppColors.pinkBright,
                ),
                // icon: Icon(
                //   Icons.refresh,
                //   color: Colors.pink,
                //   size: ScreenUtil().setSp(40),
                // )
              ),
            ),
          ),

          // ExtendedText(string: "حدثت مشكله في تحميل البيانات",
          // fontSize: ExtendedText.bigFont,
          // ),
          // Positioned(
          //   bottom: ScreenUtil().setHeight(40),
          //   right: ScreenUtil().setWidth(220),
          //   child: IconButton(
          //       icon: Icon(CommunityMaterialIcons.reload,
          //           size: ScreenUtil().setSp(60), color: Colors.pink),
          //       onPressed: () {}),
          // )
        ],
      ),
    );
  }
}
