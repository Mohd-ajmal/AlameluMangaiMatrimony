// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModelHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelHiveAdapter extends TypeAdapter<UserModelHive> {
  @override
  final int typeId = 0;

  @override
  UserModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelHive()
      ..userId = fields[0] as int
      ..username = fields[1] as String
      ..email = fields[2] as String
      ..phoneNo = fields[3] as String
      ..profileId = fields[4] as String
      ..statusInfo = fields[5] as dynamic
      ..token = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, UserModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNo)
      ..writeByte(4)
      ..write(obj.profileId)
      ..writeByte(5)
      ..write(obj.statusInfo)
      ..writeByte(6)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
