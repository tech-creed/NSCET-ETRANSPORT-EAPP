// ignore_for_file: file_names

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/SuperAdmin.dart';

class AssignSuperior extends StatefulWidget {
  const AssignSuperior({super.key});

  @override
  State<AssignSuperior> createState() => _AssignSuperiorState();
}

class _AssignSuperiorState extends State<AssignSuperior> {
  String? assigned_role = '';

  var tilesList = <Widget>[];

  var FacultyList = [];

  AdminDB adminDB = AdminDB('');
  
  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    assigned_role = prefs.getString('assigned');
    setState(() {
      assigned_role = assigned_role;
    });
  }

  @override
  void initState() {
    var faculty = adminDB.getFaculty();
    faculty.then((value) => {
      _setDetails(),
      FacultyList = (value as List)
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, "NSCET", isLogout: true),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.map, color: Colors.white, size: 29,),
          backgroundColor: Color.fromRGBO(0, 45, 77, 1),
          tooltip: 'Your Bus Map',
          elevation: 5,
          splashColor: Color.fromARGB(255, 33, 118, 175),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body:
          ListView.builder(
            // Let the ListView know how many items it needs to build.
            itemCount: FacultyList.length,
            // Provide a builder function. This is where the magic happens.
            // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index) {
              final item = FacultyList[index];
              print(item);
              return Column(children: [ListTile(
                title: Text(item['regno'].toString()),
                subtitle: Text(item['name'].toString()),
              ),
              const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 1,
                    endIndent: 1,
                  ),
              ],
              ); 
            },
          )
    );
  }
}
