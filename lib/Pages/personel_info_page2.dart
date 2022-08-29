// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:matrimony/model/matches_based_on_preference.dart';

// ignore: must_be_immutable
class PersonelInfoPage2 extends StatelessWidget {
  UserBasicInfo userBasicInfo;
  UserNativeInfo userNativeInfo;
  UserFamilyInfo userFamilyInfo;
  PersonelInfoPage2(
      this.userBasicInfo, this.userNativeInfo, this.userFamilyInfo,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'A Few Lines About Me',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              userBasicInfo.about ?? "Not specified",
              style: const TextStyle(
                  fontSize: 13,
                  wordSpacing: 1,
                  letterSpacing: 0.2,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'Basic Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            // Name Row
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Name    ',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  // 5 spaces
                  userBasicInfo.userFullName,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Age Row
            Row(
              children: [
                const SizedBox(
                    width: 120,
                    child: Text('Age', style: TextStyle(color: Colors.grey))),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userBasicInfo.age,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Gender Row
            Row(
              children: [
                const SizedBox(
                    width: 120,
                    child:
                        Text('Gender', style: TextStyle(color: Colors.grey))),
                const Text('-', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 20.0),
                Text(userBasicInfo.gender.genderName,
                    maxLines: 1, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Height Row
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
                const SizedBox(width: 20.0),
                Text(
                  userBasicInfo.height.heightFeetCm,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Weight Row
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Eating-habit',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userBasicInfo.eatingHabit.habitTypeName,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Status Row
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
                const SizedBox(width: 20.0),
                Text(
                  userBasicInfo.martialStatus.martialStatusName,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Language Row
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Language',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userBasicInfo.motherTongue.languageName!.index == 1
                      ? "Tamil"
                      : userBasicInfo.motherTongue.languageName!.index == 2
                          ? "Kannada"
                          : "English",
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Dob Row
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'DOB',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  '${userBasicInfo.dob.day}-${userBasicInfo.dob.month}-${userBasicInfo.dob.year}',
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Language Row
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Complexion',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userBasicInfo.complex.complexionName!.index == 1
                      ? "Chocolate"
                      : userBasicInfo.complex.complexionName!.index == 2
                          ? "Average"
                          : "White",
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            // const Text(
            //   'Habits',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            // ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            // Column(
            //   children: [
            //     Row(
            //       children: const [
            //         Text(
            //           'Drinking              ',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Text(
            //           '-',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Text(
            //           '     Non Drinking',
            //           maxLines: 1,
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 8.0,
            //     ),
            //     Row(
            //       children: const [
            //         Text(
            //           'Eating                 ',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Text(
            //           '-',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Text(
            //           '     Vegetarian',
            //           maxLines: 1,
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 8.0,
            //     ),
            //     Row(
            //       children: const [
            //         Text(
            //           'Smoking             ',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Text(
            //           '-',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Text(
            //           '     No',
            //           maxLines: 1,
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            //     const Text(
            //       'Hobbies',
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            //     ),
            //     const SizedBox(
            //       height: 15.0,
            //     ),

            //     const Text(
            //       'Cooking',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //     const SizedBox(
            //       height: 8.0,
            //     ),
            //     const Text(
            //       'Travelling',
            //       style: TextStyle(color: Colors.grey),
            //     ),
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        const Text(
          'Family Details',
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
                    'Father',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userFamilyInfo.userFatherName,
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
                    'Mother',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userFamilyInfo.userMotherName,
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
                    'No. of brother',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userFamilyInfo.noOfBrothers ?? "Not specified",
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
                    'No. of sisters',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userFamilyInfo.noOfSisters ?? "Not specified",
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
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
                    'Country',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  "${userNativeInfo.country}",
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
                    'State',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20.0),
                Text(
                  userNativeInfo.state.stateName,
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
                const SizedBox(width: 20.0),
                Text(
                  userNativeInfo.city.cityName,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
