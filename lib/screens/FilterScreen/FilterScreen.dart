// ignore_for_file: file_names, avoid_print
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

// variables
String? genderFilter;
String? maritalStatusFilter;
String? languageFilter;
String? religionFilter;
String? casteFilter;
String? rasiFilter;
String? starFilter;
String? educationFilter;
String? jobFilter;
String country = '';
String? state;
String? city;

// visibility check
bool _isProgress = true;
// ignore: unused_element
bool _isData = false;
bool _isStateVisible = false;
bool _isCityVisible = false;

// Hive
final box = Boxes.getTransaction();

String userId = '';
String token = '';

// listsFromServer
List jobDropDownFromServer = [];
List familyDropDownFromServer = [];
List religionDropDowndataFromServer = [];
List genderDropdownFromServer = [];
List statusDropdownFromServer = [];
List languageDropdownFromServer = [];
List casteDropDownFromServer = [];
List rasiDropDownFromServer = [];
List starDropDownFromServer = [];
List educationDropDownFromServer = [];
List countryDropDownFromServer = [];
List stateDropDownFromServer = [];
List cityDropDownFromServer = [];

// DropDown From server
List<DropdownMenuItem<String>>? get jobDropDown {
  return jobDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['job']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get religionDropdown {
  return religionDropDowndataFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['religion_name']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get educationDropDown {
  return educationDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['education']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get genderDropdown {
  return genderDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['gender']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get statusDropDown {
  return statusDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['martial_status']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get languageDropdown {
  return languageDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['language']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get casteDropDown {
  return casteDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['caste_name']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get rasiDropDown {
  return rasiDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['rasi']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get starDropDown {
  return starDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['star']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get countryDropDown {
  return countryDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['country']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get stateDropDown {
  return stateDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['state']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get cityDropDown {
  return cityDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['city']), value: e['id'].toString());
  }).toList();
}

class _FilterScreenState extends State<FilterScreen> {
  Future<void> getSWData() async {
    String urlJob =
        'https://alamelumangaimatrimony.com/api/v1/masters/job-list';
    var resJob = await http.get(Uri.parse(urlJob));
    var resJobBody = json.decode(resJob.body);

    String urlReligion =
        'https://alamelumangaimatrimony.com/api/v1/masters/religion';
    var resReligion = await http.get(Uri.parse(urlReligion));
    var resReligionBody = json.decode(resReligion.body);

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

    String urlCaste = 'https://alamelumangaimatrimony.com/api/v1/masters/caste';
    var resCaste = await http.get(Uri.parse(urlCaste));
    var resBodyCaste = json.decode(resCaste.body);

    String urlRasi =
        'https://alamelumangaimatrimony.com/api/v1/masters/rasi-list';
    var resRasi = await http.get(Uri.parse(urlRasi));
    var resBodyRasi = json.decode(resRasi.body);

    String urlstar =
        'https://alamelumangaimatrimony.com/api/v1/masters/star-list';
    var resStar = await http.get(Uri.parse(urlstar));
    var resBodyStar = json.decode(resStar.body);

    String urlEducation =
        'https://alamelumangaimatrimony.com/api/v1/masters/education-list';
    var resEducation = await http.get(Uri.parse(urlEducation));
    var resEducationBody = json.decode(resEducation.body);

    String urlCountry =
        'https://alamelumangaimatrimony.com/api/v1/masters/country-list';
    var resCountry = await http.get(Uri.parse(urlCountry));
    var resCountryBody = json.decode(resCountry.body);
    if (mounted) {
      setState(() {
        jobDropDownFromServer = resJobBody['data'];
        religionDropDowndataFromServer = resReligionBody['data'];
        genderDropdownFromServer = resBodyGender['data'];
        statusDropdownFromServer = resStatusBody['data'];
        languageDropdownFromServer = resLanguageBody['data'];
        casteDropDownFromServer = resBodyCaste['data'];
        rasiDropDownFromServer = resBodyRasi['data'];
        starDropDownFromServer = resBodyStar['data'];
        educationDropDownFromServer = resEducationBody['data'];
        countryDropDownFromServer = resCountryBody['data'];
        _isProgress = false;
        _isData = true;
        //print(resCountryBody['data']);
      });
    }
  }

  Future<void> getState() async {
    String urlstate =
        'https://alamelumangaimatrimony.com/api/v1/masters/state/state-by-country/$country';
    var resState = await http.get(Uri.parse(urlstate));
    var resBodyState = json.decode(resState.body);
    // print(country.toString());
    // print(resBodyState);
    setState(() {
      stateDropDownFromServer = resBodyState['data'];
    });
  }

  Future<void> getCity() async {
    String urlCity =
        'https://alamelumangaimatrimony.com/api/v1/masters/city/city-by-state/$state';
    var resCity = await http.get(Uri.parse(urlCity));
    var resBodyCity = json.decode(resCity.body);
    // print(state.toString());
    // print(resBodyCity);
    setState(() {
      cityDropDownFromServer = resBodyCity['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getSWData();
  }

  @override
  void dispose() {
    genderFilter = null;
    maritalStatusFilter = null;
    languageFilter = null;
    religionFilter = null;
    casteFilter = null;
    rasiFilter = null;
    starFilter = null;
    educationFilter = null;
    jobFilter = null;
    country = '';
    state = null;
    city = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: _isProgress == false
          ? ListView(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Filter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '01',
                            category: 'Gender',
                            value: null,
                            dropdown: genderDropdown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '02',
                            category: 'Marital Status',
                            value: null,
                            dropdown: statusDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '03',
                            category: 'Language',
                            value: null,
                            dropdown: languageDropdown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '04',
                            category: 'Religion',
                            value: null,
                            dropdown: religionDropdown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '05',
                            category: 'Caste',
                            value: null,
                            dropdown: casteDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '06',
                            category: 'Rasi',
                            value: null,
                            dropdown: rasiDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '07',
                            category: 'Star',
                            value: null,
                            dropdown: starDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '08',
                            category: 'Education',
                            value: null,
                            dropdown: educationDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '09',
                            category: 'Job',
                            value: null,
                            dropdown: jobDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        numberWidget(
                            number: '10',
                            category: 'Country',
                            value: null,
                            dropdown: countryDropDown),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Visibility(
                          visible: _isStateVisible,
                          child: numberWidget(
                              number: '11',
                              category: 'State',
                              value: null,
                              dropdown: stateDropDown),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Visibility(
                          visible: _isCityVisible,
                          child: numberWidget(
                              number: '12',
                              category: 'City',
                              value: null,
                              dropdown: cityDropDown),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              assignVariables();
                            },
                            child: const Text('Apply'),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }

  Widget numberWidget(
      {required String number,
      required String category,
      required String? value,
      dropdown}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black26, width: 2),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
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
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? "Select a country" : null,
                  value: value,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (category == "Gender") {
                        genderFilter = newValue!;
                      } else if (category == "Marital Status") {
                        maritalStatusFilter = newValue!;
                      } else if (category == "Language") {
                        languageFilter = newValue!;
                      } else if (category == "Religion") {
                        religionFilter = newValue!;
                      } else if (category == "Caste") {
                        casteFilter = newValue!;
                      } else if (category == "Rasi") {
                        rasiFilter = newValue!;
                      } else if (category == "Star") {
                        starFilter = newValue!;
                      } else if (category == "Education") {
                        educationFilter = newValue!;
                      } else if (category == "Job") {
                        jobFilter = newValue!;
                      } else if (category == "Country") {
                        country = newValue!;
                        getState();
                        _isStateVisible = true;
                      } else if (category == "State") {
                        state = newValue!;
                        getCity();
                        _isCityVisible = true;
                      } else if (category == "City") {
                        city = newValue!;
                      }
                      value = newValue!;
                    });
                  },
                  items: dropdown),
            ),
          ],
        ),
      ],
    );
  }

  assignVariables() {
    if (genderFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter gender'),
        ),
      );
    } else if (maritalStatusFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter marital status'),
        ),
      );
    } else if (languageFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter language'),
        ),
      );
    } else if (religionFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter religion'),
        ),
      );
    } else if (casteFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter caste'),
        ),
      );
    } else if (rasiFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Rasi'),
        ),
      );
    } else if (starFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter star'),
        ),
      );
    } else if (educationFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter education'),
        ),
      );
    } else if (jobFilter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter job'),
        ),
      );
    } else if (country.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter country'),
        ),
      );
    } else if (state == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter state'),
        ),
      );
    } else if (city == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter city'),
        ),
      );
    } else {
      postUserData(context: context);
    }
  }

  postUserData({required context}) async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/search/advance-search'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "adv_gender": genderFilter,
          "adv_marital": maritalStatusFilter,
          "adv_mother_tounge": languageFilter,
          "adv_religion": religionFilter,
          "adv_caste": casteFilter,
          "adv_rasi": rasiFilter,
          "adv_star": starFilter,
          "adv_education": educationFilter,
          "adv_job": jobFilter,
          "adv_country": country,
          "adv_state": state,
          "adv_city": city,
        });

    String responseString = response.body;
    var resBody = json.decode(responseString);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
      //print(responseString);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
      //print(response.statusCode);
      log(response.statusCode.toString());
    }
  }
}
