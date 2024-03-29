// ignore_for_file: file_names

import 'package:etransport_nscet/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:etransport_nscet/services/auth.dart';

AppBar getAppbar(context, titleName, {isLogout = false}) {
  return AppBar(
      backgroundColor: Color.fromRGBO(0, 45, 77, 1),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      title: Text(titleName),
      elevation: 1.00,
      actions: [
        isLogout
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(0, 45, 77, 1),
                ),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  AuthService().signOut();
                },
                child: Row(
                  children: const [Icon(Icons.logout_outlined), Text("Logout")],
                ),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(0, 45, 77, 1),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
builder: (context) => MyApp()), (Route route) => false);
                },
                child: Row(
                  children: const [Icon(Icons.arrow_back), Text("Back")],
                ),
              )
      ]);
}
