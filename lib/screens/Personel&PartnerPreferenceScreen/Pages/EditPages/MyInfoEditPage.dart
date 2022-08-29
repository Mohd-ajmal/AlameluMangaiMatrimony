// ignore_for_file: file_names, avoid_init_to_null, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/constants/Constants.dart';
import 'package:matrimony/model/BasicInfoUser.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class MyInfoEditPage extends StatefulWidget {
  BasicInfoUserModel basicInfoUser;

  MyInfoEditPage({Key? key, required this.basicInfoUser}) : super(key: key);

  @override
  State<MyInfoEditPage> createState() => _MyInfoEditPageState();
}

class _MyInfoEditPageState extends State<MyInfoEditPage> {
  // basic info
  late BasicInfoUserModel _basicInfoUser;

  late String userId;
  late String token;
  late String name;
  late String mobile;
  dynamic age;
  late String? gender;
  late String? height;
  late String? complexion;
  late String dob;
  late String? status;
  late String? language;
  dynamic disability;
  late String address;
  late String bloodGroup;
  late String? eatingHabit;
  dynamic about;

  List religionDropDowndataFromServer = [];
  List heightDropdownFromServer = [];
  List genderDropdownFromServer = [];
  List statusDropdownFromServer = [];
  List languageDropdownFromServer = [];
  List eatingHabitDropdownFromServer = [];
  List complextionDropdownFromServer = [];

  // Date Time
  DateTime? _dateTime = null;

  // Hive
  final box = Boxes.getTransaction();

  // visibilityCheck
  bool isSingleListView = false;
  bool isProgressBar = true;

  // Controller
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final aboutController = TextEditingController();
  final addressController = TextEditingController();
  final bloodGruopController = TextEditingController();

  List<DropdownMenuItem<String>>? get religionDropdown {
    return religionDropDowndataFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(e['religion_name']), value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get heightDropdown {
    return heightDropdownFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(
            e['height'],
            style: const TextStyle(fontSize: 12.0),
          ),
          value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get genderDropdown {
    return genderDropdownFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(
            e['gender'],
          ),
          value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get statusDropDown {
    return statusDropdownFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(
            e['martial_status'],
            style: const TextStyle(fontSize: 10.0),
          ),
          value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get languageDropdown {
    return languageDropdownFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(e['language']), value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get eatingHabitDropdown {
    return eatingHabitDropdownFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(e['habit']), value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get complextionDropdown {
    return complextionDropdownFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(e['complexion']), value: e['id'].toString());
    }).toList();
  }

  Future<void> getSWData() async {
    String url = 'https://alamelumangaimatrimony.com/api/v1/masters/religion';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    String urlHeight =
        'https://alamelumangaimatrimony.com/api/v1/masters/height';
    var resHeight = await http.get(Uri.parse(urlHeight));
    var resBodyHeight = json.decode(resHeight.body);

    String urlGender =
        'https://alamelumangaimatrimony.com/api/v1/masters/gender';
    var resGender = await http.get(Uri.parse(urlGender));
    var resBodyGender = json.decode(resGender.body);

    String urlStatus =
        'https://alamelumangaimatrimony.com/api/v1/masters/m-status';
    var resStatus = await http.get(Uri.parse(urlStatus));
    var resStatusBody = json.decode(resStatus.body);

    String urlLanguage =
        'https://alamelumangaimatrimony.com/api/v1/masters/language';
    var resLanguage = await http.get(Uri.parse(urlLanguage));
    var resLanguageBody = json.decode(resLanguage.body);

    String urlEatingHabit =
        'https://alamelumangaimatrimony.com/api/v1/masters/eating-habit';
    var resEatingHabit = await http.get(Uri.parse(urlEatingHabit));
    var resEatingHabitbody = json.decode(resEatingHabit.body);

    String urlComplexion =
        'https://alamelumangaimatrimony.com/api/v1/masters/complexion';
    var resComplexion = await http.get(Uri.parse(urlComplexion));
    var resComplexionbody = json.decode(resComplexion.body);

    setState(() {
      religionDropDowndataFromServer = resBody['data'];
      heightDropdownFromServer = resBodyHeight['data'];
      genderDropdownFromServer = resBodyGender['data'];
      statusDropdownFromServer = resStatusBody['data'];
      languageDropdownFromServer = resLanguageBody['data'];
      eatingHabitDropdownFromServer = resEatingHabitbody['data'];
      complextionDropdownFromServer = resComplexionbody['data'];
      isSingleListView = true;
      isProgressBar = false;
    });
    //print(statusDropdownFromServer);
  }

  @override
  void initState() {
    super.initState();
    getSWData();
    final transaction = box.values.toList().cast<UserModelHive>();
    nameController.text = transaction.last.username;
    mobileController.text = transaction.last.phoneNo;

    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    _basicInfoUser = widget.basicInfoUser;
    aboutController.text = _basicInfoUser.data.about ?? '';
    addressController.text = _basicInfoUser.data.userAddress ?? "";
    bloodGruopController.text = _basicInfoUser.data.bloodGroup ?? "";
    mobile = '';
    name = '';
    gender = '';
    height = '';
    complexion = '';
    dob = '';
    status = '';
    language = '';
    address = '';
    bloodGroup = '';
    eatingHabit = '';
  }

  @override
  Widget build(BuildContext context) {
    //print(height!.isEmpty ? 'not' : height);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Screen',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: isProgressBar == false
          ? Visibility(
              visible: isSingleListView,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Mobile',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: mobileController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
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
                      TextField(
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
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
                      TextField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: bloodGruopController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${_basicInfoUser.data.dob.day.toString()} / ${_basicInfoUser.data.dob.month.toString()} / ${_basicInfoUser.data.dob.year.toString()}'),
                          IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1960),
                                lastDate: DateTime(2100),
                              ).then((value) {
                                setState(() {
                                  _dateTime = value!;
                                  dob =
                                      '${_dateTime!.day}-${_dateTime!.month}-${_dateTime!.year}';
                                });
                              });
                            },
                            icon: const Icon(Icons.calendar_today_outlined),
                          )
                        ],
                      ),
                      details(
                          name1: 'Age',
                          name2: 'Height',
                          dropdown1: Constants.dropdownItems,
                          dropdown2: heightDropdown,
                          value1: null,
                          value2: null,
                          identify1: 'age',
                          identify2: 'height',
                          fontSize1: 8),
                      const SizedBox(
                        height: 10.0,
                      ),
                      details(
                          name1: 'Gender',
                          name2: 'Status',
                          dropdown1: genderDropdown,
                          dropdown2: statusDropDown,
                          value1: null,
                          value2: null,
                          identify1: 'gender',
                          identify2: 'status'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      details(
                          name1: 'Mother tongue',
                          name2: 'Eating habit',
                          dropdown1: languageDropdown,
                          dropdown2: eatingHabitDropdown,
                          value1: null,
                          value2: null,
                          identify1: 'language',
                          identify2: 'eatingHabit'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      details(
                          name1: 'Complexion',
                          name2: 'Disability',
                          dropdown1: complextionDropdown,
                          dropdown2: Constants.disabilityDropdown,
                          value1: null,
                          value2: null,
                          identify1: 'complexion',
                          identify2: 'disability'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'A few lines about you',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.done,
                        maxLines: 10,
                        controller: aboutController,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: ElevatedButton(
                              onPressed: () {
                                assignVariables();
                              },
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget details(
      {required name1,
      required name2,
      required List<DropdownMenuItem<String>>? dropdown1,
      required List<DropdownMenuItem<String>>? dropdown2,
      required String? value1,
      required String? value2,
      required String identify1,
      required String identify2,
      int? fontSize1}) {
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
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  hint: getValue1(identify1: identify1),
                  value: value1,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (identify1 == 'age') {
                        age = newValue;
                      } else if (identify1 == 'gender') {
                        gender = newValue;
                      } else if (identify1 == 'language') {
                        language = newValue;
                      } else if (identify1 == 'complexion') {
                        complexion = newValue;
                      }
                      value1 = newValue!;
                    });
                  },
                  items: dropdown1),
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
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  hint: getValue2(identify2: identify2),
                  value: value2,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (identify2 == 'height') {
                        height = newValue;
                      } else if (identify2 == 'status') {
                        status = newValue;
                      } else if (identify2 == 'eatingHabit') {
                        eatingHabit = newValue;
                      } else if (identify2 == 'disability') {
                        disability = newValue;
                      }
                      value2 = newValue!;
                    });
                  },
                  items: dropdown2),
            ],
          ),
        ),
      ],
    );
  }

  postUserData({required context}) async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/basic-info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "user_full_name": nameController.text,
          "mobile": mobileController.text,
          "age": age ?? '${_basicInfoUser.data.age}',
          "height":
              height!.isEmpty ? '${_basicInfoUser.data.height.id}' : height,
          "about": aboutController.text,
          "gender":
              gender!.isEmpty ? '${_basicInfoUser.data.gender.id}' : gender,
          "dob":
              '${_basicInfoUser.data.dob.year}-${_basicInfoUser.data.dob.month}-${_basicInfoUser.data.dob.day}',
          "user_complexion": complexion!.isEmpty
              ? '${_basicInfoUser.data.complexion.id}'
              : complexion,
          "martial_status": status!.isEmpty
              ? '${_basicInfoUser.data.martialStatus.id}'
              : status,
          "mother_tongue": language!.isEmpty
              ? '${_basicInfoUser.data.language.id}'
              : language,
          "eating_habit": eatingHabit!.isEmpty
              ? '${_basicInfoUser.data.eatingHabit.id}'
              : eatingHabit,
          "disability": disability ?? '${_basicInfoUser.data.isDisable}',
          "user_address": addressController.text.isEmpty
              ? _basicInfoUser.data.userAddress
              : addressController.text,
          "blood_group": bloodGruopController.text.isEmpty
              ? _basicInfoUser.data.bloodGroup
              : bloodGruopController.text,
          "is_tenth_passed": "1"
        });
    //print(response.body);
    if (response.statusCode == 200) {
      String responseString = response.body;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Basic Info updated successfully'),
        ),
      );
      //print(responseString);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong, please try again'),
        ),
      );
      //print(response.statusCode);
    }
  }

  Widget getValue1({required identify1}) {
    if (identify1 == 'age') {
      return Text(_basicInfoUser.data.age ?? '');
    } else if (identify1 == 'gender') {
      return Text(_basicInfoUser.data.gender.gender);
    } else if (identify1 == 'language') {
      return Text(_basicInfoUser.data.language.language);
    } else if (identify1 == 'complexion') {
      return Text(_basicInfoUser.data.complexion.complexion);
    } else {
      return const Text('');
    }
  }

  Widget getValue2({required identify2}) {
    if (identify2 == 'height') {
      return Text(
        _basicInfoUser.data.height.height,
        style: const TextStyle(fontSize: 12.0),
      );
    } else if (identify2 == 'status') {
      return Text(
        _basicInfoUser.data.martialStatus.martialStatus,
        style: const TextStyle(fontSize: 10.0),
      );
    } else if (identify2 == 'eatingHabit') {
      return Text(_basicInfoUser.data.eatingHabit.habit);
    } else if (identify2 == 'disability') {
      return Text(_basicInfoUser.data.isDisable == '0' ? 'No' : 'Yes');
    } else {
      return const Text('');
    }
  }

  assignVariables() {
    if (age == null && _basicInfoUser.data.age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide age'),
        ),
      );
    } else if (addressController.text.isEmpty &&
        _basicInfoUser.data.userAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide address'),
        ),
      );
    } else if (bloodGruopController.text.isEmpty &&
        _basicInfoUser.data.bloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide blood group'),
        ),
      );
    } else if (height!.isEmpty && _basicInfoUser.data.height.height.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide height'),
        ),
      );
    } else if (gender!.isEmpty && _basicInfoUser.data.gender.gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide gender'),
        ),
      );
    } else if (status!.isEmpty &&
        _basicInfoUser.data.martialStatus.martialStatus.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide marital status'),
        ),
      );
    } else if (language!.isEmpty &&
        _basicInfoUser.data.language.language.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide mother tongue'),
        ),
      );
    } else if (eatingHabit!.isEmpty &&
        _basicInfoUser.data.eatingHabit.habit.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide eating habit'),
        ),
      );
    } else if (complexion!.isEmpty &&
        _basicInfoUser.data.complexion.complexion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide complextion'),
        ),
      );
    } else if (disability == null && _basicInfoUser.data.isDisable == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide disability'),
        ),
      );
    } else if (aboutController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please provide something about you\nin few lines about you'),
        ),
      );
    } else {
      postUserData(context: context);
    }

    // print(
    //     'BasicInfo ${nameController.text}, ${mobileController.text}, ${_basicInfoUser.data.age}, ${_basicInfoUser.data.height.id.toString()}, ${_basicInfoUser.data.gender.id}, ${_basicInfoUser.data.martialStatus.id}, ${_basicInfoUser.data.language.id}');
    // print(
    //     'BasicInfo ${_basicInfoUser.data.eatingHabit.id}, ${_basicInfoUser.data.complexion.id}, ${_basicInfoUser.data.isDisable}, ${aboutController.text}');

    // print(
    //     ' ${nameController.text}, ${mobileController.text}, ${age}, ${height}, ${gender}, ${status}, ${language}');
    // print(
    //     ' ${eatingHabit}, ${complexion}, ${disability}, ${aboutController.text}');
  }
}
