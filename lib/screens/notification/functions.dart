import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

Function onScrollDown = (BuildContext context) {
  Provider.of<VMRootUi>(context).hideBars = true;
};

Function onScrollUp = (BuildContext context) {
  Provider.of<VMRootUi>(context).hideBars = false;
};

onScrollAction(
    ScrollController scrollController, bool hideBars, BuildContext context,
    {Function onScrolldown, Function onScrollUp}) {
  if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse &&
      hideBars)
    onScrollDown(context);
  else if (Provider.of<VMRootUi>(context).hideBars && !hideBars)
    onScrollUp(context);
}
