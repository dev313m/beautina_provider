import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';


class GetLoadingWidget extends StatelessWidget {
  GetLoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Loading(
      indicator: BallScaleIndicator(),
      size: 55,
    ));
  }
}
