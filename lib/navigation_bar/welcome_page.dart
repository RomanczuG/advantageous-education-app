// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.first_name, required this.result})
      : super(key: key);
  final String first_name;
  final num result;
  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Map<String, double> examResult = {
    "Correct answers in %": 70,
    "Wrong answers in %": 30,
  };
  List<Color> colorList = [
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    // Users Data Reference
    CollectionReference userData =
        FirebaseFirestore.instance.collection('users');

    // MAIN COLUMN

    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // HI MESSAGE
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      // User's Name
                      Row(
                        children: [
                          Text(
                            "Hi ",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.first_name}!',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      // TEAM MESSAGE
                      Text(
                        'Welcome to the app created with Advantageous.Education students in mind. It allows you to scan your test answers which are then analyzed by Machine Learning algorithms that help us decide how much time you should spend on a given amount of material.',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      // BREAK
                    ]),
                  )),
              SizedBox(
                height: 20,
              ),
              // TASKS TITLE
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Tasks',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // FIRST TASK
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        '1. Take the Exam',
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // SECOND TASK
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        '2. Send a picture of the scantron',
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Recent exam score',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // RESULT SAT
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            'SAT',
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15),
                          ),
                          PieChart(
                            dataMap: {
                              "Correct points": widget.result.toDouble(),
                              "Wrong points": 1600 - widget.result.toDouble(),
                            },
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.height / 7,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            // MAIN COLUMN
          )),
    );
  }
}
