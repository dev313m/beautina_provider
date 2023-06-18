import 'package:beautina_provider/core/states/core/common.dart';

networkStatefulVarStarter(
    {required NetworkStatefulVar networkStatefulVarClass,
    Function? onStart,
    Function? onLoading,
    Function? onError}) {
  networkStatefulVarClass.isError.value = false;
  networkStatefulVarClass.isLoading.value = true;
  networkStatefulVarClass.isReady.value = false;
  networkStatefulVarClass.isFinishSuccess.value = false;

  if (onLoading != null) onLoading();
  try {
    if (onStart != null) onStart();
    networkStatefulVarClass.isError.value = false;
    networkStatefulVarClass.isLoading.value = false;
    networkStatefulVarClass.isFinishSuccess.value = true;
  } catch (e) {
    if (onError != null) onError();
    networkStatefulVarClass.isError.value = true;
    networkStatefulVarClass.isLoading.value = false;
  }
}
