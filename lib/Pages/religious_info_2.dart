// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:matrimony/model/matches_based_on_preference.dart';

class ReliginInfo2 extends StatelessWidget {
  UserReligeonInfo userReligeonInfo;
  ReliginInfo2(this.userReligeonInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Religion Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Caste',
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
                  userReligeonInfo.belongsToCaste.casteName,
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
                    'Sub Cast',
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
                  userReligeonInfo.subCaste ?? "Not specified",
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
                    'Religion',
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
                  userReligeonInfo.belognsToReligion.religionName,
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
                    'Rasi',
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
                  userReligeonInfo.belongsToRasi.rasiName ?? "Not spcified",
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
                    'Star',
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
                  userReligeonInfo.belongsToStar.starName ?? "Not specified",
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
                    'Birth place',
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
                  userReligeonInfo.userBirthPlace ?? "Not specified",
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
                    'Birth time',
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
                  userReligeonInfo.userBirthTime ?? "Not specified",
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
                    'Dhosam',
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
                  userReligeonInfo.dhosam == "0"
                      ? "Nothing"
                      : userReligeonInfo.dhosam,
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
    );
  }
}
