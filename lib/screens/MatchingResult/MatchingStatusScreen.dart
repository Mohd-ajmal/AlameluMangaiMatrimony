// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class MatchingStatusScreen extends StatelessWidget {
  String image;
  String name;
  String ageAndHeight;
  String state;
  String professtion;

  MatchingStatusScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.ageAndHeight,
    required this.state,
    required this.professtion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Matching Results',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/SummaModel.jpeg'),
                        ),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text('Saravanan'),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(ageAndHeight),
                  ],
                ),
                Text(
                  '95%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(image),
                        ),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(name),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(ageAndHeight),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            numberWidget(
                number: '01', category: 'Basic Details', percentage: '100%'),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Living In $state',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text('Status - Never Married',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text('Income 33,000',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                numberWidget(
                    number: '02',
                    category: 'Interest And Hobbies',
                    percentage: '82%'),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(left: 40, top: 20),
                    child: Wrap(
                      runSpacing: 5.0,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Knowledge'),
                              Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Programming'),
                              Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Singing'),
                              Icon(
                                Icons.do_not_disturb_outlined,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Swimming'),
                              Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Movie'),
                              Icon(
                                Icons.do_not_disturb,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Dancing'),
                              Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            numberWidget(
                number: '03', category: 'Religion And Work', percentage: '50%'),
            Container(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Religion - Gujarati',
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Work - Software Developer',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numberWidget(
      {required number, required category, required percentage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Text(
          percentage,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        )
      ],
    );
  }
}
