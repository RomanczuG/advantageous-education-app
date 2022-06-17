// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_exam_analysis/forgot_page.dart';
import 'package:ai_exam_analysis/settings_pages/change_page.dart';
import 'package:ai_exam_analysis/settings_pages/contact_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ai_exam_analysis/forgot_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {Key? key, required this.first_name, required this.last_name})
      : super(key: key);
  final String first_name;
  final String last_name;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }

  final Uri _url = Uri.parse('https://advantageous.education');
  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    CollectionReference userData =
        FirebaseFirestore.instance.collection('users');
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(children: [
        Row(
          children: [
            Image.asset(
              'assets/images/student.png',
              height: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '${widget.first_name} ${widget.last_name}',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.blue.shade900,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Divider(
          height: 20,
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return changeFirstNamePage();
              }));
            }),
            child: buildAccountOption('Change first name')),
        GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return changeLastNamePage();
              }));
            },
            child: buildAccountOption('Change last name')),
        GestureDetector(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ForgotPasswordPage();
              }));
            }),
            child: buildAccountOption('Change password')),
        SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Icon(
              Icons.email,
              color: Colors.blue.shade900,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Contact',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Divider(
          height: 20,
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EmailSender(
                  emailAddress: 'contact@advantageous.education',
                  subjectMessage: 'Message to the team',
                );
              }));
            },
            child: buildAccountOption('Email our team')),
        GestureDetector(
            onTap: _launchUrl, child: buildAccountOption('Visit our website')),
        GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EmailSender(
                  emailAddress: 'contact@advantageous.education',
                  subjectMessage: 'Feedback',
                );
              }));
            },
            child: buildAccountOption('Send us your feedback')),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: signOut,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.blue.shade900,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Sign Out',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

Widget buildAccountOption(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600)),
        Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey.shade600,
        )
      ],
    ),
  );
}
