// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beauty_provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelBeautyProviderAdapter extends TypeAdapter<ModelBeautyProvider> {
  @override
  final int typeId = 1;

  @override
  ModelBeautyProvider read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelBeautyProvider(
      location: (fields[11] as List?)?.cast<double>(),
      available: fields[5] as bool?,
      image: fields[6] as String?,
      type: fields[4] as int?,
      default_accept: fields[27] as bool?,
      email: fields[9] as String?,
      token: fields[30] as String?,
      package: (fields[25] as Map?)?.cast<String, dynamic>(),
      intro: fields[8] as String?,
      name: fields[12] as String?,
      customers: fields[7] as double?,
      points: fields[20] as int?,
      service_duration: (fields[10] as Map?)?.cast<String, int>(),
      default_after_accept: fields[28] as int?,
      tokenId: fields[16] as String?,
      busyDates: (fields[3] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, DateTime>())
          .toList(),
      favorite_count: fields[21] as int?,
      auth_login: fields[18] as String?,
      rating: fields[24] as double?,
      register_date: fields[23] as DateTime?,
      voter: fields[13] as int?,
      country: fields[31] as String?,
      likes: fields[32] as int?,
      visitors: fields[22] as int?,
      firebaseUid: fields[2] as String?,
      city: fields[19] as String?,
      uid: fields[15] as String?,
      username: fields[14] as String?,
      achieved: fields[17] as int?,
      phone: fields[29] as String?,
    )
      ..TYPE_SALON = fields[0] as int
      ..TYPE_INDIVIDUAL = fields[1] as int
      ..servicespro = (fields[26] as Map?)?.cast<String, dynamic>();
  }

  @override
  void write(BinaryWriter writer, ModelBeautyProvider obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.TYPE_SALON)
      ..writeByte(1)
      ..write(obj.TYPE_INDIVIDUAL)
      ..writeByte(2)
      ..write(obj.firebaseUid)
      ..writeByte(3)
      ..write(obj.busyDates)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.available)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.customers)
      ..writeByte(8)
      ..write(obj.intro)
      ..writeByte(9)
      ..write(obj.email)
      ..writeByte(10)
      ..write(obj.service_duration)
      ..writeByte(11)
      ..write(obj.location)
      ..writeByte(12)
      ..write(obj.name)
      ..writeByte(13)
      ..write(obj.voter)
      ..writeByte(14)
      ..write(obj.username)
      ..writeByte(15)
      ..write(obj.uid)
      ..writeByte(16)
      ..write(obj.tokenId)
      ..writeByte(17)
      ..write(obj.achieved)
      ..writeByte(18)
      ..write(obj.auth_login)
      ..writeByte(19)
      ..write(obj.city)
      ..writeByte(20)
      ..write(obj.points)
      ..writeByte(21)
      ..write(obj.favorite_count)
      ..writeByte(22)
      ..write(obj.visitors)
      ..writeByte(23)
      ..write(obj.register_date)
      ..writeByte(24)
      ..write(obj.rating)
      ..writeByte(25)
      ..write(obj.package)
      ..writeByte(26)
      ..write(obj.servicespro)
      ..writeByte(27)
      ..write(obj.default_accept)
      ..writeByte(28)
      ..write(obj.default_after_accept)
      ..writeByte(29)
      ..write(obj.phone)
      ..writeByte(30)
      ..write(obj.token)
      ..writeByte(31)
      ..write(obj.country)
      ..writeByte(32)
      ..write(obj.likes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelBeautyProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
