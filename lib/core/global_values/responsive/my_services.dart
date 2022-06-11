import 'package:beautina_provider/core/global_values/core/common.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:beautina_provider/core/models/response/my_service.dart';
import 'package:get/state_manager.dart';

// class GlobalValMyServices extends AsyncApiGetx<List<ModelMyService>> {
//   Rx<bool> isServicesListAsRootLeafReady = Rx(false);
//   Rx<bool> isServicesListAsRootLeafError = Rx(false);

//   RxList<ModelService> servicesListAsRootLeaf = RxList<ModelService>([]);
//   GlobalValMyServices()
//       : super(api: MyServicesController().getMyServicesList(), value: Rx([])) {
//     MyServicesController().setMyServicesAsNodes();
//   }
//   Future refresh() async {
//     super.api = MyServicesController().getMyServicesList();
//     MyServicesController().setMyServicesAsNodes();
//   }
// }

class GlobalValMyServices extends NetworkStatefulVar {
  RxList<ModelMyService> myService = RxList<ModelMyService>([]);
  RxList<ModelService> servicesListAsRootLeaf = RxList<ModelService>([]);
}
