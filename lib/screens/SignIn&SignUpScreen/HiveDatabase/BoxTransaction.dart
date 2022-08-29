// ignore_for_file: file_names
import 'package:hive/hive.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class Boxes {
  static Box<UserModelHive> getTransaction() => Hive.box('transaction');
}
