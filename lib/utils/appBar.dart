// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:etransport_nscet/services/auth.dart';

AppBar getAppbar(context, titleName, {isLogout = false}) {
  return AppBar(
      backgroundColor: const Color.fromRGBO(199, 68, 109, 1),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      title: Text(titleName),
      elevation: 1.00,
      actions: [
        isLogout
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(199, 68, 109, 1),
                ),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  AuthService().signOut();
                },
                child: Row(
                  children: const [
                    Icon(Icons.logout_outlined),
                    Text(" Logout")
                  ],
                ),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(199, 68, 109, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [Icon(Icons.arrow_back), Text(" Back")],
                ),
              )
      ]);
}
