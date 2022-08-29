import 'package:flutter/material.dart';
import 'package:matrimony/model/BasicInfoUser.dart';
import 'package:matrimony/model/ShortlistModel.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

// ignore: must_be_immutable
class ShortListBasicInfo extends StatefulWidget {
  ShortlistBasicInfo? shortlistBasicInfo;
  String username;
  ShortListBasicInfo(this.shortlistBasicInfo, this.username, {Key? key})
      : super(key: key);

  @override
  State<ShortListBasicInfo> createState() => _ShortListBasicInfoState();
}

class _ShortListBasicInfoState extends State<ShortListBasicInfo> {
  // variables
  late String userId;
  late String token;
  late String name;
  late String mobile;
  dynamic age;
  late String gender;
  late String height;
  late String complexion;
  late String dob;
  late String status;
  late String language;
  dynamic disability;
  late String eatingHabit;
  dynamic about;
  String _userAdress = '';
  String _bloodGroup = '';

  late BasicInfoUserModel _basicInfoUser;

  // Hive
  final box = Boxes.getTransaction();
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getUserData(context: context);
    mobile = '';
    name = '';
    gender = '';
    height = '';
    complexion = '';
    dob = '';
    status = '';
    language = '';
    disability = '';
    eatingHabit = '';
  }

  @override
  Widget build(BuildContext context) {
    return name.isNotEmpty
        ? SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Basic Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
                        child: Text(widget.username),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      details(
                          name1: 'Age',
                          value1: age ?? 'Not specified',
                          name2: 'Gender',
                          value2: gender),
                      const SizedBox(
                        height: 10.0,
                      ),
                      details(
                          name1: 'Height',
                          value1: height.isEmpty ? 'Not specified' : height,
                          name2: 'Complexion',
                          value2: complexion.isEmpty
                              ? 'Not specified'
                              : complexion),
                      const SizedBox(
                        height: 10.0,
                      ),
                      details(
                        name1: 'DOB',
                        value1: dob,
                        name2: 'Status',
                        value2: status.isEmpty ? 'Not specified' : status,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      details(
                          name1: 'Mother tongue',
                          value1: language.isEmpty ? 'Not specified' : language,
                          name2: 'disability',
                          value2: disability == 0 ? 'Yes' : 'No'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Eating habit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
                        child: Text(eatingHabit.isEmpty
                            ? 'Not specified'
                            : eatingHabit),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
                        child: Text(_userAdress.isEmpty
                            ? "Not specified"
                            : _userAdress),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Blood group',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
                        child: Text(_bloodGroup.isEmpty
                            ? "Not specified"
                            : _bloodGroup),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'About',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black12, width: 2),
                        ),
                        child: Text(about ?? 'Not Specified'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator.adaptive());
  }

  Widget details(
      {required name1, required value1, required name2, required value2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(value1),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(value2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getUserData({required context}) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/basic-info/${widget.shortlistBasicInfo!.userId}';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(res.statusCode);
    if (res.statusCode == 200) {
      _basicInfoUser = basicInfoUserModelFromJson(res.body);
      if (mounted) {
        setState(() {
          name = _basicInfoUser.data.userFullName;
          mobile = _basicInfoUser.data.userMobileNo;
          age = _basicInfoUser.data.age.toString();
          gender = _basicInfoUser.data.gender.gender;
          height = _basicInfoUser.data.height.height;
          complexion = _basicInfoUser.data.complexion.complexion;
          dob = _basicInfoUser.data.dob.toString();
          status = _basicInfoUser.data.martialStatus.martialStatus;
          language = _basicInfoUser.data.language.language;
          disability = _basicInfoUser.data.isDisable;
          eatingHabit = _basicInfoUser.data.eatingHabit.habit;
          about = _basicInfoUser.data.about;
          _userAdress = _basicInfoUser.data.userAddress ?? "Not specified";
          _bloodGroup = _basicInfoUser.data.bloodGroup ?? "Not specified";
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }
}
