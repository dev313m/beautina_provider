import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';

class SettingsPersonalInfoUsecase {
  String? name;
  String? phone;
  String? city;
  String? desc;
  String? country;
  SettingsPersonalInfoUsecase(
      {this.desc, this.name, this.phone, this.city, this.country});
}

class SettingsPersonalInfoRepo {
  Future updatePersonalInfo(SettingsPersonalInfoUsecase settings) async {}

  initSettingsPersonalUsercase(
      SettingsPersonalInfoUsecase settingsPersonalInfoUsecase) {
    var bp = BeautyProviderController.getBeautyProviderProfile();
    settingsPersonalInfoUsecase.desc = bp.intro ?? '';
    settingsPersonalInfoUsecase.name = bp.name;
    settingsPersonalInfoUsecase.phone = bp.phone;
    settingsPersonalInfoUsecase.city = bp.city;
    settingsPersonalInfoUsecase.country = bp.country;
  }

  validateInput(SettingsPersonalInfoUsecase settingsPersonalInfoUsecase) {
    if (settingsPersonalInfoUsecase.phone!.length < 13 ||
        settingsPersonalInfoUsecase.name == '')
      throw Exception('يجب وضع معلومات صحيحة');
  }
}
