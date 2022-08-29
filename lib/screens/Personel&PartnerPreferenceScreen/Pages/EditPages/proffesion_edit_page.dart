// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/proffesion_model.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class ProffesionEditPage2 extends StatefulWidget {
  ProffesionModel? proffesionModel;
  ProffesionEditPage2(this.proffesionModel, {Key? key}) : super(key: key);

  @override
  State<ProffesionEditPage2> createState() => _ProffesionEditPage2State();
}

List<DropdownMenuItem<String>>? get countryDropDown {
  return _countryDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['country']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get stateDropDown {
  return _stateDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['state']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get cityDropDown {
  return _cityDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['city']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get jobDropDown {
  return _jobDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['job']), value: e['id'].toString());
  }).toList();
}

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// controllers
var educationDetailController = TextEditingController();
var jobDetailsController = TextEditingController();
var annualIncomController = TextEditingController();

String _selectedJob = '';
String _selectedCountry = '';
String _selectedState = '';
String _selectedCity = '';
List _selectedEducation = [];

List _educaitonDropDownFromServer = [];
List _countryDropDownFromServer = [];
List _stateDropDownFromServer = [];
List _cityDropDownFromServer = [];
List _jobDropDownFromServer = [];

// visibility
bool _isProgress = true;

class _ProffesionEditPage2State extends State<ProffesionEditPage2> {
  Future<void> getSWData() async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/masters/education-list';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    String urlJob =
        'https://alamelumangaimatrimony.com/api/v1/masters/job-list';
    var resJob = await http.get(Uri.parse(urlJob));
    var resBodyJob = json.decode(resJob.body);

    String urlCountry =
        'https://alamelumangaimatrimony.com/api/v1/masters/country-list';
    var resCountry = await http.get(Uri.parse(urlCountry));
    var resCountryBody = json.decode(resCountry.body);

    if (mounted) {
      setState(() {
        _educaitonDropDownFromServer = resBody['data'];
        _countryDropDownFromServer = resCountryBody['data'];
        _jobDropDownFromServer = resBodyJob['data'];
        _isProgress = false;
      });
      log(_educaitonDropDownFromServer.toString());
      log(_countryDropDownFromServer.toString());
    }
  }

  Future<void> getState() async {
    String urlstate =
        'https://alamelumangaimatrimony.com/api/v1/masters/state/state-by-country/$_selectedCountry';
    var resState = await http.get(Uri.parse(urlstate));
    log(resState.statusCode.toString());
    var resBodyState = json.decode(resState.body);
    //print(country.toString());
    setState(() {
      _stateDropDownFromServer = resBodyState['data'];
    });
  }

  Future<void> getCity() async {
    String urlCity =
        'https://alamelumangaimatrimony.com/api/v1/masters/city/city-by-state/$_selectedState';
    var resCity = await http.get(Uri.parse(urlCity));
    var resBodyCity = json.decode(resCity.body);
    setState(() {
      _cityDropDownFromServer = resBodyCity['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getSWData();
    educationDetailController.text =
        widget.proffesionModel?.data.educationDetails ?? "";
    jobDetailsController.text = widget.proffesionModel?.data.jobDetails ?? "";
    annualIncomController.text =
        widget.proffesionModel?.data.annualIncome ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Edit proffesion",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _isProgress == false
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Education',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black12, width: 2),
                      ),
                      child: MultiSelectDialogField(
                        buttonText: Text(widget.proffesionModel == null
                            ? "Not specified"
                            : widget.proffesionModel!.data.education!.isEmpty
                                ? "Not specified"
                                : getEducationArrayToString(
                                    list: widget
                                            .proffesionModel?.data.education ??
                                        [])),
                        items: _educaitonDropDownFromServer
                            .map(
                                (e) => MultiSelectItem(e['id'], e['education']))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          _selectedEducation = values;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Education details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: educationDetailController,
                      decoration: InputDecoration(
                        hintText:
                            widget.proffesionModel?.data.educationDetails ?? "",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Job',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText:
                                        widget.proffesionModel?.data.job!.job ??
                                            "",
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  value: null,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      _selectedJob = newValue;
                                    });
                                  },
                                  items: jobDropDown),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Job details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: jobDetailsController,
                      decoration: InputDecoration(
                        hintText: widget.proffesionModel?.data.jobDetails ?? "",
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Working country',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.proffesionModel?.data
                                            .jobCountry!.country ??
                                        "",
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  value: null,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      _selectedCountry = newValue;
                                      getState();
                                      log(_selectedCountry);
                                    });
                                  },
                                  items: countryDropDown),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Working State',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.proffesionModel?.data
                                            .jobState!.state ??
                                        "",
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  value: null,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      _selectedState = newValue;
                                      getCity();
                                    });
                                  },
                                  items: stateDropDown),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Working City',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.proffesionModel?.data
                                            .jobCity!.city ??
                                        "",
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  value: null,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      _selectedCity = newValue;
                                      getCity();
                                    });
                                  },
                                  items: cityDropDown),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Education details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: annualIncomController,
                      decoration: InputDecoration(
                        hintText:
                            widget.proffesionModel?.data.annualIncome ?? "",
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
                              validation();
                            },
                            child: const Text('Done'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
    );
  }

  validation() {
    if (_selectedEducation.isEmpty && widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter education")));
    } else if (educationDetailController.text.isEmpty &&
        widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter education details")));
    } else if (_selectedJob.isEmpty && widget.proffesionModel == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please enter job")));
    } else if (jobDetailsController.text.isEmpty &&
        widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter job details")));
    } else if (_selectedCountry.isEmpty && widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter working country")));
    } else if (_selectedState.isEmpty && widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter working state")));
    } else if (_selectedCity.isEmpty && widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter working city")));
    } else if (annualIncomController.text.isEmpty &&
        widget.proffesionModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter annual income")));
    } else {
      postUserData(context: context);
    }
  }

  postUserData({required context}) async {
    var resBody1 = {};
    resBody1['user_education'] = _selectedEducation.isEmpty
        ? widget.proffesionModel?.data.education!.map((e) => e.id).toList()
        : _selectedEducation;
    resBody1['user_education_details'] = educationDetailController.text;
    resBody1['user_job'] = _selectedJob.isEmpty
        ? widget.proffesionModel?.data.job!.id
        : _selectedJob;
    resBody1['user_job_details'] = jobDetailsController.text;
    resBody1['user_working_country'] = _selectedCountry.isEmpty
        ? widget.proffesionModel?.data.jobCountry!.id
        : _selectedCountry;
    resBody1['user_working_state'] = _selectedState.isEmpty
        ? widget.proffesionModel?.data.jobState!.id
        : _selectedState;
    resBody1['user_working_city'] = _selectedCity.isEmpty
        ? widget.proffesionModel?.data.jobCity!.id
        : _selectedCity;
    resBody1['user_annual_income'] = annualIncomController.text;
    var js = json.encode(resBody1);
    print(js);
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/professional-info'),
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: js);

    String responseString = response.body;
    var resBody = json.decode(responseString);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['errors'].toString()),
        ),
      );
    }
  }

  String getEducationArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element.educationName + '  ';
    }
    return returnType;
  }
}
