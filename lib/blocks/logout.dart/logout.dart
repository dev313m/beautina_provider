import 'package:beautina_provider/blocks/constants/app_colors.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/controller/erros_controller.dart';
import 'package:beautina_provider/core/controller/refresh_controller.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/index.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BlockLogout extends StatelessWidget {
  const BlockLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController buttonController =
        RoundedLoadingButtonController();

    return RoundedLoadingButton(
      controller: buttonController,
      borderRadius: radiusDefault,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: GWdgtTextButton(
                string: 'تسجيل الخروج',
              ),
            ),
          ),
        ],
      ),
      onPressed: () async {
        buttonController.start();
        try {
          await BeautyProviderController().logout();
          await RefreshController.onStart();
          await RefreshController.onStartNotRegistered();

          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: LoginPage()));
        } catch (e) {
          ErrorController.logError(
              exception: e, eventName: BeautyProviderController.ErrLogout);
          showToast('Can\'t logout now..');
        }
      },
      color: AppColors.pinkOpcity,
      animateOnTap: false,
    );
  }
}
