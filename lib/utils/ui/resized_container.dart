import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

class GWdgtContainerScale extends StatelessWidget {
  final Widget child;
  const GWdgtContainerScale({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      child,
    );
  }
}
