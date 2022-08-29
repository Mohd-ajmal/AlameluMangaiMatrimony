// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:matrimony/model/profile_list_model.dart';

@immutable
// ignore: must_be_immutable
class PreferencesPage extends StatelessWidget {
  BasicPartnerInfo basicPartnerInfo;
  PreferencesPage(this.basicPartnerInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'Partner Preferences',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 120.0,
                  child: Text(
                    'Age',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '${basicPartnerInfo.partnerAgeFrom} - ${basicPartnerInfo.partnerAgeTo}',
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Height',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  "${basicPartnerInfo.partnerHeightFrom} - ${basicPartnerInfo.partnerHeightTo}",
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Status',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  basicPartnerInfo.partnerMartialStatus ?? "Not specified",
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'Professionl Preferences',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Education',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  getEducationArrayToString(
                      list: basicPartnerInfo.partnerEducation ?? []),
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Occupation',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  getJobName(list: basicPartnerInfo.partnerJob ?? []),
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            // const Text(
            //   'Religion Preferences',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            // ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 120,
            //       child: Text(
            //         'Cast',
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     ),
            //     const Text(
            //       '-',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //     const SizedBox(
            //       width: 20.0,
            //     ),
            //     Text(
            //       basicPartnerInfo.partnerCaste ?? "Not specified",
            //       maxLines: 1,
            //       style: const TextStyle(color: Colors.grey),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 120,
            //       child: Text(
            //         'Sub Cast',
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     ),
            //     const Text(
            //       '-',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //     const SizedBox(width: 20),
            //     Text(
            //       basicPartnerInfo.partnerCaste ?? "Not specified",
            //       maxLines: 1,
            //       style: const TextStyle(color: Colors.grey),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 120,
            //       child: Text(
            //         'Religion',
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     ),
            //     const Text(
            //       '-',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     Text(
            //       basicPartnerInfo.partnerReligion ?? "Not specified",
            //       maxLines: 1,
            //       style: const TextStyle(color: Colors.grey),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Citizenship',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(
                      '-',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      basicPartnerInfo.partnerCountry![0].countryName ??
                          "Not specified",
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Country',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(
                      '-',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      basicPartnerInfo.partnerCountry![0].countryName
                          .toString(),
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'City',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(
                      '-',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      basicPartnerInfo.partnerCity ?? "Not specified",
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String getEducationArrayToString({required List list}) {
    String returnType = '';
    for (int i = 0; i < list.length; i++) {
      returnType += list[i].educationName + '  ';
    }
    return returnType;
  }

  String getJobName({required List list}) {
    String returnType = '';
    for (int i = 0; i < list.length; i++) {
      returnType += list[i].jobName + '  ';
    }
    return returnType;
  }

  String getJobCountryArrayToString({required List list}) {
    //print(list);
    String returnType = '';
    for (var element in list) {
      returnType += list[element].countryName + '  ';
    }
    return returnType;
  }
}
