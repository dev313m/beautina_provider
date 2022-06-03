class SettingsPersonalInfoUsecase {
  String? name;
  String? phone;
  String? desc;
  SettingsPersonalInfoUsecase({this.desc, this.name, this.phone});
}

class SettingsPersonalInfoRepo {
  Future updatePersonalInfo(SettingsPersonalInfoUsecase settings) async {}
}
