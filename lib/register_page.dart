// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistePage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegistePage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegistePage> createState() => _RegistePageState();
}

class _RegistePageState extends State<RegistePage> {
  // TextField Controllers
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cofirmPasswordController = TextEditingController();

  // Dispose data
  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _cofirmPasswordController.dispose();
    super.dispose();
  }

  // SignUp method with FirebaseAuth
  Future signUp() async {
    if (passwordCofirmed()) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        Navigator.of(context).pop();
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

      // add user's details

      final data = {
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim()
      };

      addUserDetails(data);
    }
  }

  Future addUserDetails(data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(data);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('results')
        .doc('exams')
        .set({'exam1': 0});
  }

  // Check is the password is the same
  bool passwordCofirmed() {
    if (_passwordController.text.trim() ==
        _cofirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Hello again!

              Text(
                "Hello!",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "Register below with your email.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              SizedBox(
                height: 50,
              ),

              // Email textfield

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
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                      ),
                    )),
              ),

              // First name

              SizedBox(
                height: 10,
              ),

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

              // Last name

              SizedBox(
                height: 10,
              ),
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

              // Password textfield

              SizedBox(
                height: 10,
              ),

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
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                      ),
                    )),
              ),

              // Re-password textfield

              SizedBox(
                height: 10,
              ),

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
                        controller: _cofirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password'),
                      ),
                    )),
              ),

              // Sign up button

              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      primary: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: signUp,
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  )),

              // Member
              SizedBox(
                height: 25,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text('I am a member!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(" Login now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
