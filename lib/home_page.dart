// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:ai_exam_analysis/navigation_bar/camera_page.dart';
import 'package:ai_exam_analysis/navigation_bar/welcome_page.dart';
import 'package:ai_exam_analysis/navigation_bar/settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;
  late String _first_name = '';
  late String _last_name = '';
  late num _result = 0;

  void getUserData() async {
    // late Map<String, dynamic> data;
    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      print(data['first_name']);
      setState(() {
        _first_name = data['first_name'];
        _last_name = data['last_name'];
      });
    } catch (error) {
      print(error);
    }
  }

  void getResults() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('results')
        .doc('exams');
    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      print(data['exam1']);
      setState(() {
        _result = data['exam1'];
      });
    } catch (error) {
      print(error);
    }
  }

  void initState() {
    super.initState();
    getUserData();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = <Widget>[
      WelcomePage(
        first_name: _first_name,
        result: _result,
      ),
      CameraPage(),
      SettingsPage(
        first_name: _first_name,
        last_name: _last_name,
      ),
    ];
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),

          // Navigation Bar

          child: GNav(
            duration: Duration(milliseconds: 400),
            haptic: true,
            rippleColor: Colors.blueGrey.shade300,
            activeColor: Colors.white,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            tabBackgroundColor: Colors.blueGrey.shade400,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.camera_alt_outlined,
                text: 'Upload the picture',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child:
              // Displays chosen pages
              _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
