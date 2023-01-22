// ignore_for_file: file_names
import 'package:etransport_nscet/pages/SuperAdmin/AssignSuperior.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/pages/Home/Home.dart';
import 'package:etransport_nscet/pages/Authentication/VerificationPage.dart';
import 'package:etransport_nscet/services/auth.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  bool showVerification = false;
  final AuthService _auth = AuthService();
  void showVerifyView() {
    setState(() {
      showVerification = true;
    });
  }

  void hideVerifyView() {
    setState(() {
      showVerification = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_auth.getCurrentUser()!.emailVerified) {
      showVerifyView();
    }
    if (showVerification) {
      return const VerificationPage();
    } else {
      return const Home();
    }
  }
}
