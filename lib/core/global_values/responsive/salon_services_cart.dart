import 'package:get/state_manager.dart';

class GlobalValSalonServicesCart extends GetxController {
  RxList<String> salonServicesCart = RxList([]);

  addService({required String code}) {
    salonServicesCart.add(code);
  }

  removeService({required String code}) {
    salonServicesCart.remove(code);
  }
}
