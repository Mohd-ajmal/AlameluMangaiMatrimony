// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget HomeDrawerList(BuildContext context) {
  var currentPage = NavigationDrawerList.Home;
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        menuItem(
            id: 1,
            title: 'Home',
            icon: const Icon(Icons.home_outlined),
            selected: currentPage == NavigationDrawerList.Home ? true : false,
            context: context),
        const Divider(),
        menuItem(
            id: 2,
            title: 'Matches',
            icon: const Icon(Icons.people_outlined),
            selected:
                currentPage == NavigationDrawerList.Matches ? true : false,
            context: context),
        const Divider(),
        menuItem(
            id: 3,
            title: 'Search',
            icon: const Icon(Icons.search_outlined),
            selected: currentPage == NavigationDrawerList.Search ? true : false,
            context: context),
        const Divider(),
        menuItem(
            id: 4,
            title: 'Profile',
            icon: const Icon(Icons.person_outline),
            selected:
                currentPage == NavigationDrawerList.Profile ? true : false,
            context: context),
        const Divider(),
        menuItem(
            id: 5,
            title: 'About Us',
            icon: const Icon(Icons.business_outlined),
            selected:
                currentPage == NavigationDrawerList.AboutUs ? true : false,
            context: context),
        const Divider(),
      ],
    ),
  );
}

Widget menuItem(
    {required int id,
    required String title,
    required Icon icon,
    required bool selected,
    required BuildContext context}) {
  return Material(
    child: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: icon),
            Expanded(
                flex: 3,
                child: Text(title, style: const TextStyle(fontSize: 16)))
          ],
        ),
      ),
    ),
  );
}

enum NavigationDrawerList {
  Home,
  Matches,
  Search,
  Profile,
  AboutUs,
}
