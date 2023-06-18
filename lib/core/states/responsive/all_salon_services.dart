import 'package:beautina_provider/core/controller/all_salon_services_controller.dart';
import 'package:beautina_provider/core/states/core/async_api.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:get/state_manager.dart';

class GlobalValAllServices extends AsyncApiGetx<List<ModelService>> {
  GlobalValAllServices()
      : super(api: AllSalonServicesController.getServices(), value: Rx([])) {}
}
