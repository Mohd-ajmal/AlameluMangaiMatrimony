// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/PpProffesionModel.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class PpProffesionPreferenceEditPage extends StatefulWidget {
  PpProffestionalModel ppProffestionalModel;
  PpProffesionPreferenceEditPage({Key? key, required this.ppProffestionalModel})
      : super(key: key);

  @override
  State<PpProffesionPreferenceEditPage> createState() =>
      _PpProffesionPreferenceEditPageState();
}

// selected items
List selectedEducation = [];
List selectedJob = [];
List selectJobCountry = [];

bool progressBar = true;
bool container = false;

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// from server
List educaitonDropDownFromServer = [];
List partnerJobDropDownFromServer = [];
List partnerJobCountryDropDownFromServer = [];

// controller
final partnerEducaitonController = TextEditingController();
final partnerJobDetailsController = TextEditingController();
final salary = TextEditingController();

class _PpProffesionPreferenceEditPageState
    extends State<PpProffesionPreferenceEditPage> {
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
        educaitonDropDownFromServer = resBody['data'];
        partnerJobDropDownFromServer = resBodyJob['data'];
        partnerJobCountryDropDownFromServer = resCountryBody['data'];
        progressBar = false;
        container = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    partnerEducaitonController.text =
        widget.ppProffestionalModel.data.partnerEducationDetails ?? "";
    partnerJobDetailsController.text =
        widget.ppProffestionalModel.data.partnerJobDetails ?? "";
    salary.text = widget.ppProffestionalModel.data.partnerSalary ?? "";
    getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return progressBar == false
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
                    'Partner Education',
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
                      buttonText: Text(widget.ppProffestionalModel.data
                              .partnerEducation.isEmpty
                          ? "Not specified"
                          : getEducationArrayToString(
                              list: widget
                                  .ppProffestionalModel.data.partnerEducation)),
                      items: educaitonDropDownFromServer
                          .map((e) => MultiSelectItem(e['id'], e['education']))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectedEducation = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Partner Education Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    maxLines: 5,
                    controller: partnerEducaitonController,
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
                    height: 10.0,
                  ),
                  const Text(
                    'Partner Job',
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
                      buttonText: Text(widget.ppProffestionalModel.data
                              .partnerEducation.isEmpty
                          ? "Not specified"
                          : getJobArrayToString(
                              list:
                                  widget.ppProffestionalModel.data.partnerJob)),
                      items: partnerJobDropDownFromServer
                          .map((e) => MultiSelectItem(e['id'], e['job']))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectedJob = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Partner Job Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    maxLines: 5,
                    controller: partnerJobDetailsController,
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
                    height: 10.0,
                  ),
                  const Text(
                    'Partner Job Country',
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
                      buttonText: Text(widget.ppProffestionalModel.data
                              .partnerEducation.isEmpty
                          ? "Not specified"
                          : getJobCountryArrayToString(
                              list: widget.ppProffestionalModel.data
                                  .partnerJobCountry)),
                      items: partnerJobCountryDropDownFromServer
                          .map((e) => MultiSelectItem(e['id'], e['country']))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectJobCountry = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Partner Salary',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    maxLines: 1,
                    controller: salary,
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
                    height: 10.0,
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
                            postUserData(context: context);
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
            child: CircularProgressIndicator.adaptive(),
          );
  }

  assignVariables() {
    if (selectedEducation.isEmpty &&
        widget.ppProffestionalModel.data.partnerEducation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide partner education"),
        ),
      );
    } else if (partnerEducaitonController.text.isEmpty &&
        widget.ppProffestionalModel.data.partnerEducationDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide partner education details"),
        ),
      );
    } else if (partnerJobDropDownFromServer.isEmpty &&
        widget.ppProffestionalModel.data.partnerJob.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide partner job"),
        ),
      );
    } else if (partnerJobDetailsController.text.isEmpty &&
        widget.ppProffestionalModel.data.partnerJobDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide partner Job details"),
        ),
      );
    } else if (partnerJobCountryDropDownFromServer.isEmpty &&
        widget.ppProffestionalModel.data.partnerJobCountry.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide partner Job country"),
        ),
      );
    } else if (salary.text.isEmpty &&
        widget.ppProffestionalModel.data.partnerSalary == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide partner salary"),
        ),
      );
    } else {
      postUserData(context: context);
    }
  }

  postUserData({required context}) async {
    var resBody1 = {};
    resBody1['partner_education'] = selectedEducation.isEmpty
        ? widget.ppProffestionalModel.data.partnerEducation
            .map((e) => e['id'])
            .toList()
        : selectedEducation;
    resBody1['partner_education_details'] =
        partnerEducaitonController.text.isEmpty
            ? widget.ppProffestionalModel.data.partnerEducationDetails
            : partnerEducaitonController.text;
    resBody1['partner_job'] = selectedJob.isEmpty
        ? widget.ppProffestionalModel.data.partnerJob
            .map((e) => e['id'])
            .toList()
        : selectedJob;
    resBody1['partner_job_details'] = partnerJobDetailsController.text.isEmpty
        ? widget.ppProffestionalModel.data.partnerJobDetails
        : partnerJobDetailsController.text;
    resBody1['partner_job_country'] = selectJobCountry.isEmpty
        ? widget.ppProffestionalModel.data.partnerJobCountry
            .map((e) => e['id'])
            .toList()
        : selectJobCountry;
    resBody1['partner_annual_income'] = salary.text.isEmpty
        ? widget.ppProffestionalModel.data.partnerSalary
        : salary.text;
    var js = json.encode(resBody1);
    //print(js);
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/prefference-info-professional'),
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
    list.forEach((element) {
      returnType += element['education_name'] + '  ';
    });
    return returnType;
  }

  String getJobArrayToString({required List list}) {
    String returnType = '';
    list.forEach((element) {
      returnType += element['job_name'] + '  ';
    });
    return returnType;
  }

  String getJobCountryArrayToString({required List list}) {
    String returnType = '';
    list.forEach((element) {
      returnType += element['country_name'] + '  ';
    });
    return returnType;
  }
}
