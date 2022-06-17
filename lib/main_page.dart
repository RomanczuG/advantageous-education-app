import 'dart:io';

import 'package:ai_exam_analysis/firebase_options.dart';
import 'package:ai_exam_analysis/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';
import 'home_page.dart';
import 'storageManager.dart';
import 'package:ai_exam_analysis/main_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
