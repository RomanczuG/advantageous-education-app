// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// CHANGE FIRST NAME
class changeFirstNamePage extends StatefulWidget {
  const changeFirstNamePage({Key? key}) : super(key: key);

  @override
  State<changeFirstNamePage> createState() => _changeFirstNamePageState();
}

class _changeFirstNamePageState extends State<changeFirstNamePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _firstNameController = TextEditingController();

  Future changeName() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    // Set new data
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'first_name': _firstNameController.text.trim()});
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('First name was changed!'),
            );
          });
    } on FirebaseAuthException catch (error) {
      print(error);
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Change your first name'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Text Enter your email

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter first name and restart the app',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),

        SizedBox(
          height: 10,
        ),

        // Text Field

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First name'),
                ),
              )),
        ),
        SizedBox(
          height: 10,
        ),

        // Button Reset Password

        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: Colors.blueGrey,
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              onPressed: changeName,
              child: Center(
                  child: Text(
                "Change first name",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
            )),
      ]),
    );
  }
}

// CHANGE LAST NAME

class changeLastNamePage extends StatefulWidget {
  const changeLastNamePage({Key? key}) : super(key: key);

  @override
  State<changeLastNamePage> createState() => _changeLastNamePageState();
}

class _changeLastNamePageState extends State<changeLastNamePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _lastNameController = TextEditingController();

  Future changeName() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    // Set new data
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'last_name': _lastNameController.text.trim()});
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Last name was changed!'),
            );
          });
    } on FirebaseAuthException catch (error) {
      print(error);
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Change your last name'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Text Enter your email

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter last name and restart the app',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),

        SizedBox(
          height: 10,
        ),

        // Text Field

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Last name'),
                ),
              )),
        ),
        SizedBox(
          height: 10,
        ),

        // Button Reset Password

        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: Colors.blueGrey,
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              onPressed: changeName,
              child: Center(
                  child: Text(
                "Change last name",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
            )),
      ]),
    );
  }
}
