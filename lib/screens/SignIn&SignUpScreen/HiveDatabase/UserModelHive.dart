// ignore_for_file: file_names
import 'package:hive/hive.dart';

part 'UserModelHive.g.dart';

@HiveType(typeId: 0)
class UserModelHive extends HiveObject {
  @HiveField(0)
  late int userId;
  @HiveField(1)
  late String username;
  @HiveField(2)
  late String email;
  @HiveField(3)
  late String phoneNo;
  @HiveField(4)
  late String profileId;
  @HiveField(5)
  dynamic statusInfo;
  @HiveField(6)
  late String token;
}
