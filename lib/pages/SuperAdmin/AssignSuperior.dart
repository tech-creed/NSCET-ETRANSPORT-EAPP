// ignore_for_file: file_names

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/superAdmin.dart';
import '../../utils/SnackBar.dart';

class AssignSuperior extends StatefulWidget {
  const AssignSuperior({super.key});

  @override
  State<AssignSuperior> createState() => _AssignSuperiorState();
}

class _AssignSuperiorState extends State<AssignSuperior> {
  String? assigned_role = '';
  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];

  String facultyNameHod = '';
  String facultyNameHodDept = '';
  String facultyNameBusIncharge = '';

  List<DropdownMenuItem<Object>> dacultyDropdownList = [];
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
      FacultyList = (value as List),
      for (int i = 0; i < FacultyList.length; i++)
        {
          dacultyDropdownList.add(DropdownMenuItem(
            child: Text(FacultyList[i]['name'].toString()),
            value: FacultyList[i]['user_id'].toString(),
          ))
          // if(FacultyList[i]['assigned_role'].toString() == ' '){

          // }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, "Assign Superiors", isLogout: true),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.map,
            color: Colors.white,
            size: 29,
          ),
          backgroundColor: Color.fromRGBO(0, 45, 77, 1),
          tooltip: 'Your Bus Map',
          elevation: 5,
          splashColor: Color.fromARGB(255, 33, 118, 175),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  Text(
                    "Assign Department HOD",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Choose Faculty to Assign";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.bookmark_outline,
                        color: Color.fromRGBO(78, 138, 186, 1),
                      ),
                      labelText: 'Select Department',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(9, 83, 145, 1), width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text("Science and Humanites"),
                        value: "S&H",
                      ),
                      DropdownMenuItem(
                        child: Text("Computer Science & Engineering"),
                        value: "CSE",
                      ),
                      DropdownMenuItem(
                        child: Text("Mechanical Engineering"),
                        value: "MECH",
                      ),
                      DropdownMenuItem(
                        child: Text("Electronics & Communication Engg"),
                        value: "ECE",
                      ),
                      DropdownMenuItem(
                        child: Text("Civil Engineering"),
                        value: "CIVIL",
                      ),
                      DropdownMenuItem(
                        child: Text("Electrical & Electronics Engineering"),
                        value: "EEE",
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        facultyNameHodDept = val.toString();
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Choose Faculty to Assign";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person_2,
                        color: Color.fromRGBO(78, 138, 186, 1),
                      ),
                      labelText: 'Select Faculty',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(9, 83, 145, 1), width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                      ),
                    ),
                    items: dacultyDropdownList,
                    onChanged: (val) {
                      setState(() {
                        facultyNameHod = val.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(35, 123, 196, 1),
                        padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                    onPressed: () async {
                      dynamic result = await adminDB.setHodFacultyRole(
                          facultyNameHod, facultyNameHodDept);
                      if (result != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(getSnackBar(result.toString()));
                      }
                      // if (_formkey.currentState!.validate()) {

                      //   // dynamic result = await _auth.register(email, password, name, role, dept, regno);
                      //   // if (result != null) {
                      //   //   ScaffoldMessenger.of(context).showSnackBar(getSnackBar(result.message.toString()));
                      //   // }
                      // }
                    },
                    child: const Text(
                      "Assign HOD",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                    indent: 1,
                    endIndent: 1,
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    "Assign Transport Incharge",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Choose Faculty to Assign";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.bus_alert_rounded,
                        color: Color.fromRGBO(78, 138, 186, 1),
                      ),
                      labelText: 'Select Faculty',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(9, 83, 145, 1), width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                      ),
                    ),
                    items: dacultyDropdownList,
                    onChanged: (val) {
                      setState(() {
                        facultyNameBusIncharge = val.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(35, 123, 196, 1),
                        padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                    onPressed: () async {
                      dynamic result =
                          await adminDB.setTransportInchargeFacultyRole(
                              facultyNameBusIncharge);
                      if (result != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(getSnackBar(result.toString()));
                      }
                      // if (_formkey.currentState!.validate()) {
                      // dynamic result = await _auth.register(email, password, name, role, dept, regno);
                      // if (result != null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(getSnackBar(result.message.toString()));
                      // }
                      // }
                    },
                    child: const Text(
                      "Assign Transport Incharge",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                    indent: 1,
                    endIndent: 1,
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    "Assign Super Admin",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Choose Faculty to Assign";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person_2_sharp,
                        color: Color.fromRGBO(78, 138, 186, 1),
                      ),
                      labelText: 'Select Faculty',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(9, 83, 145, 1), width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                      ),
                    ),
                    items: dacultyDropdownList,
                    onChanged: (val) {
                      setState(() {
                        facultyNameBusIncharge = val.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(35, 123, 196, 1),
                        padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                    onPressed: () async {
                      dynamic result = await adminDB
                          .setSuperAdminRole(facultyNameBusIncharge);
                      if (result != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(getSnackBar(result.toString()));
                      }
                      // if (_formkey.currentState!.validate()) {
                      // dynamic result = await _auth.register(email, password, name, role, dept, regno);
                      // if (result != null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(getSnackBar(result.message.toString()));
                      // }
                      // }
                    },
                    child: const Text(
                      "Assign Super Admin",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ));
  }
}
