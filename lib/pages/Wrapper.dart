// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/pages/Authentication/Authenticate.dart';
import 'package:etransport_nscet/pages/Home/HomeWrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const HomeWrapper();
    }
  }
}
