import 'package:ai_exam_analysis/login_page.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: toggleScreens,
      );
    } else {
      return RegistePage(showLoginPage: toggleScreens);
    }
  }
}
