// ignore_for_file: file_names, must_be_immutable, constant_identifier_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matrimony/screens/FilterScreen/FilterScreen.dart';
import 'package:matrimony/screens/ProfileScreen/shorlistScreen/ShorlistScreen.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';

import 'HomeContainer.dart';
import '../ProfileScreen/ProfileScreen.dart';
import '../SearchScreen/SearchScreen.dart';
import '../MatchesScreen/MatchesScreen.dart';
import 'navigationDrawer/HomeHeaderDrawer.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({Key? key}) : super(key: key);

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  var currentPage = NavigationDrawerList.Home;
  var container;
  late String title;
  late bool visible;
  final box = Boxes.getTransaction();

  // openSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  // }

  @override
  void initState() {
    super.initState();
    container = const HomeScreen();
    title = 'Home';
    visible = false;
  }

  @override
  Widget build(BuildContext context) {
    //final transaction = box.values.toList().cast<UserModelHive>();
    // print(transaction.last.token);
    // print(transaction.last.userId);
    // print(transaction.last.profileId);
    //openSharedPreferences();

    if (currentPage == NavigationDrawerList.Home) {
      container = const HomeScreen();
      title = 'Home';
      visible = false;
    } else if (currentPage == NavigationDrawerList.Matches) {
      container = const MatchesScreen();
      title = 'Matches';
      visible = true;
    } else if (currentPage == NavigationDrawerList.Search) {
      container = const SearchScreen();
      title = 'Search';
      visible = false;
    } else if (currentPage == NavigationDrawerList.Profile) {
      container = const ProfileScreen();
      title = 'Profile';
      visible = false;
    } else if (currentPage == NavigationDrawerList.Shortlist) {
      container = const ShortlistScreen();
      title = 'Shortlist';
      visible = false;
    }
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const HomeScreenDrawer(),
            HomeDrawerList(context),
            const Spacer(),
            const Center(
                child: Text('Designed by',
                    style: TextStyle(
                      color: Colors.grey,
                    ))),
            const Text("Exciteon",
                style: TextStyle(fontFamily: "AkagiPro", fontSize: 30.0)),
            const Text('Tree of technology',
                style: TextStyle(color: Colors.grey, fontSize: 18.0)),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Visibility(
            visible: visible,
            child: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilterScreen()),
                  );
                });
              },
              icon: const Icon(
                Icons.filter_alt,
                color: Colors.black54,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: container,
    );
  }

  Widget HomeDrawerList(BuildContext context) {
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
          menuItem(
              id: 2,
              title: 'Matches',
              icon: const Icon(Icons.people_outlined),
              selected:
                  currentPage == NavigationDrawerList.Matches ? true : false,
              context: context),
          menuItem(
              id: 3,
              title: 'Search',
              icon: const Icon(Icons.search_outlined),
              selected:
                  currentPage == NavigationDrawerList.Search ? true : false,
              context: context),
          menuItem(
              id: 4,
              title: 'Profile',
              icon: const Icon(Icons.person_outline),
              selected:
                  currentPage == NavigationDrawerList.Profile ? true : false,
              context: context),
          menuItem(
              id: 5,
              title: 'Shortlist',
              icon: const Icon(Icons.people_outline),
              selected:
                  currentPage == NavigationDrawerList.Shortlist ? true : false,
              context: context),
          const SizedBox(
            height: 100.0,
          ),
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
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = NavigationDrawerList.Home;
            } else if (id == 2) {
              currentPage = NavigationDrawerList.Matches;
            } else if (id == 3) {
              currentPage = NavigationDrawerList.Search;
            } else if (id == 4) {
              currentPage = NavigationDrawerList.Profile;
            } else if (id == 5) {
              currentPage = NavigationDrawerList.Shortlist;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: icon),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum NavigationDrawerList { Home, Matches, Search, Profile, Shortlist }
