// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:matrimony/model/PpBasicInfoModel.dart';
import 'package:matrimony/model/PpProffesionModel.dart';
import 'package:matrimony/model/PpreligionPreference.dart';

import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/PpBasicInfoEditPage.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/PpProffesionPreferenceEditPage.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/religion_preference_edit.dart';

class PartnerPreferenceEditPage extends StatefulWidget {
  PpBasicInfo ppBasicInfo;
  PpProffestionalModel ppProffestionalModel;
  PpReligionPreference ppReligionPreference;
  PartnerPreferenceEditPage(
      {Key? key,
      required this.ppBasicInfo,
      required this.ppProffestionalModel,
      required this.ppReligionPreference})
      : super(key: key);

  @override
  State<PartnerPreferenceEditPage> createState() =>
      _PartnerPreferenceEditPageState();
}

class _PartnerPreferenceEditPageState extends State<PartnerPreferenceEditPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
          title: const Text(
            "Edit Partner Preference",
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.green[100],
            isScrollable: true,
            tabs: const [
              Tab(
                text: "Basic Preference",
              ),
              Tab(
                text: "Proffession Preference",
              ),
              Tab(
                text: "Religion Preference",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PpBasicInfoEditPage(
              ppBasicInfo: widget.ppBasicInfo,
            ),
            PpProffesionPreferenceEditPage(
              ppProffestionalModel: widget.ppProffestionalModel,
            ),
            PpReligiousEditPage(widget.ppReligionPreference)
          ],
        ),
      ),
    );
  }
}
