import 'package:beautina_provider/core/controller/my_services_controller.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';

class BlockAddServiceRepo {
  Future addService(ModelService service, double duration, double cost) async {
    await MyServicesController.addService(service, duration, cost);
  }

  Future disableService(ModelService service) async {
    await MyServicesController.disableService(service);
  }
}
