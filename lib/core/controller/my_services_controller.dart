import 'package:beautina_provider/core/db/my_services.dart';
import 'package:beautina_provider/core/models/response/my_service.dart';

class MyServicesController {
  static Future<bool> postService(ModelMyService modelMyService) async {
    DBMyService _myServices = DBMyService();
    try {
      _myServices.addAService(modelMyService.toMap());
      return true;
    } catch (e) {
      return false;
    }
    // var apiList = await _myServices.apiAllServices();
    // return tree;
  }

  // Future<bool> addService()
}
