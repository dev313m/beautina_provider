import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[String]
///
final strInstruction = 'اضغطي هنا لفتح-ايقاف استلام الطلبات:';
final strFlare = 'assets/rive/lock.flr';
final strLock = 'lock';
final strUnlock = 'unlock';

///[size]
double sizeContainer = 200.h;

///[radius]
double radius = 12;

class WAvailablilityChanger extends StatefulWidget {
  final DateTime changableAvailableDate;

  const WAvailablilityChanger({
    Key key,
    this.changableAvailableDate,
  }) : super(key: key);

  @override
  _WAvailablilityChangerState createState() => _WAvailablilityChangerState();
}

class _WAvailablilityChangerState extends State<WAvailablilityChanger> {
  bool available = true;
  bool isLoading = false;
  bool isAvailabilityChecked = false;
  @override
  void initState() {
    super.initState();
    checkAvalability(widget.changableAvailableDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeContainer,

      // decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GWdgtTextSmall(
            string: strInstruction,
            textAlign: TextAlign.start,
            textDirection: TextDirection.rtl,
            // fontSize: ExtendedText.defaultFont,
          ),
          Container(
            height: sizeContainer,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                // width: 400,

                height: sizeContainer,
                child: InkWell(
                  borderRadius: BorderRadius.circular(radius),
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */
                      ModelBeautyProvider mbp = await sharedUserProviderGetInfo();

                      //Clear old dates
                      List<Map<String, DateTime>> newBusyDates = clearOldBusyDates(mbp.busyDates);
                      //update busy dates
                      newBusyDates = changeAvaDates(widget.changableAvailableDate, mbp);

                      await apiBeautyProviderUpdate(mbp..busyDates = newBusyDates);

                      Provider.of<VMSalonData>(context).beautyProvider = mbp;
                      Provider.of<VMSalonData>(context).beautyProvider = await sharedUserProviderGetInfo();

                      isAvailabilityChecked = false;
                      checkAvalability(widget.changableAvailableDate);
                    } catch (e) {
                      showToast('حدث خطأ اثناء التحديث');
                    }
                    isLoading = false;

                    setState(() {});
                  },
                  child: Stack(
                    children: <Widget>[
                      FlareActor(
                        strFlare,
                        animation: available ? strUnlock : strLock,
                        shouldClip: false,
                        snapToEnd: false,
                        // artboard: available ? 'open' : 'closed',
                        // animation: available ? 'open' : 'closed',

                        // controller: ,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: isLoading ? Loading() : SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, DateTime>> changeAvaDates(DateTime requiredDate, ModelBeautyProvider modelBeautyProvider) {
    List<Map<String, DateTime>> newBusyDates;
    DateTime fixedDate = DateTime(requiredDate.year, requiredDate.month, requiredDate.day);

    ///
    ///This is to remove any old date
    ///
    if (available)
      newBusyDates = modelBeautyProvider.busyDates..add({'from': fixedDate, 'to': fixedDate.add(Duration(days: 1))});
    else
      newBusyDates = modelBeautyProvider.busyDates
        ..removeWhere((element) {
          if (element['from'].year == requiredDate.year &&
              element['from'].month == requiredDate.month &&
              element['from'].day == requiredDate.day) return true;
          return false;
        });

    return newBusyDates;
  }

  List<Map<String, DateTime>> clearOldBusyDates(List<Map<String, DateTime>> listDates) {
    DateTime dayTimeNow = DateTime.now();
    for (int i = 0; i < listDates.length; i++) {
      if (listDates[i]['from'].isBefore(dayTimeNow)) listDates.removeAt(i);
    }

    return listDates;
  }

  Future<void> removeAllOldDates() async {}

  ///THis method checks availablity and if it was check for better performance we do a flag
  Future<bool> checkAvalability(DateTime requiredDate) async {
    if (isAvailabilityChecked) return available;
    bool availableDate = true;
    await Future.delayed(Duration(milliseconds: 300));
    ModelBeautyProvider beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
    List<Map<String, DateTime>> busyDates = beautyProvider.busyDates;
    busyDates.forEach((element) {
      if (requiredDate.isAfter(element['from'].subtract(Duration(minutes: 1))) && requiredDate.isBefore(element['to']))
        availableDate = false;
    });
    isAvailabilityChecked = true;
    setState(() {
      available = availableDate;
    });
    return availableDate;
  }
}
