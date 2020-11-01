import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/auth/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetChangeEmail extends StatefulWidget {
  final ModelBeautyProvider beautyProvider;
  WidgetChangeEmail({Key key, this.beautyProvider}) : super(key: key);

  @override
  _WidgetChangeEmailState createState() => _WidgetChangeEmailState();
}

class _WidgetChangeEmailState extends State<WidgetChangeEmail> {
  RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: _controller,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ExtendedText(
                string: 'تغيير الايميل',
                fontSize: ExtendedText.bigFont,
              ),
            ),
          ),
          ExtendedText(string: widget.beautyProvider.email),
          SizedBox(height: ScreenUtil().setHeight(10))
        ],
      ),
      onPressed: () async {
        String result;
        try {
          result = await signInWithGoogle();
          // showToast(result);
        } catch (e) {
          showToast(e.toString());
          // animationController.reverse();
        }
        // if (result != null) await saveUserData(context);
      },
      color: Colors.purple,
      animateOnTap: false,
    );
  }
}
