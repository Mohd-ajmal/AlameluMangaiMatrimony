// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:matrimony/model/matches_based_on_preference.dart';

// ignore: must_be_immutable
class ProffesionalPage2 extends StatelessWidget {
  UserProfessionInfo userProfessionInfo;
  ProffesionalPage2(this.userProfessionInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Proffesional Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 130,
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
                      list: userProfessionInfo.userEducationId ?? []),
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
                  width: 130,
                  child: Text(
                    'Annual Income',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  userProfessionInfo.userAnnualIncome ?? "Not specified",
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
                  width: 130,
                  child: Text(
                    'Education Details',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Text(
                  '-',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  userProfessionInfo.userEducationDetails ?? "Not specified",
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
                  width: 130,
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
                  width: 20.0,
                ),
                Expanded(
                  child: Text(
                    userProfessionInfo.userJobDetails ?? "Not specified",
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 130,
            //       child: Text(
            //         'Employed in',
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
            //       userProfessionalInfo ?? "Not specified",
            //       maxLines: 1,
            //       style: const TextStyle(color: Colors.grey),
            //     ),
            //   ],
            // ),
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
}
