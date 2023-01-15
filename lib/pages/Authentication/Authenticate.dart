// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:etransport_nscet/pages/Authentication/ForgotPassword.dart';
import 'package:etransport_nscet/pages/Authentication/Register.dart';
import 'package:etransport_nscet/pages/Authentication/SignIn.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int showSignIn = 2;

  void toggleView(int tog) {
    setState(() {
      showSignIn = tog;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == 0) {
      return Register(toggleView: toggleView);
    }
    if (showSignIn == 1) {
      return ForgotPassword(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }
}
