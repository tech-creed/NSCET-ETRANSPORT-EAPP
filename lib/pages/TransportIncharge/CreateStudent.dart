// ignore_for_file: file_names

import 'dart:async';
import 'package:etransport_nscet/services/attendanceDB.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/superAdmin.dart';
import '../../services/busCreate.dart';
import '../../utils/SnackBar.dart';

class AssignStudent extends StatefulWidget {
  const AssignStudent({super.key});

  @override
  State<AssignStudent> createState() => _AssignStudentState();
}

class _AssignStudentState extends State<AssignStudent> {
  String? assigned_role = '';
  String studentName = '';
  String studentNumber = '';
  String studentDept = '';
  String studentRoute = '';
  String studentStop = '';

  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];
  var StopList = [];
  final routes_ref = FirebaseDatabase.instance.ref('routes');
  List<DropdownMenuItem<Object>> StopDropDown = [];

  AttendanceDB attendanceDB = AttendanceDB('');

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    assigned_role = prefs.getString('assigned');

    setState(() {
      assigned_role = assigned_role;
    });
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, "Create Student", isLogout: true),
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
        body: StreamBuilder(
            stream: routes_ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              final tilesList = <Widget>[];
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                var i = 0;
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;

                List<DropdownMenuItem<Object>> routesID = [];

                routesID.clear();

                map.forEach(
                  (key, value) {
                    routesID.add(DropdownMenuItem(
                      child: Text(value['routeName'].toString()),
                      value: key.toString(),
                    ));
                  },
                );
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30.0),
                          Text(
                            "Create Student",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter your name' : null,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(78, 138, 186, 1),
                                ),
                                labelText: 'Student Name',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(0, 45, 77, 1)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(9, 83, 145, 1),
                                      width: 1.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(78, 138, 186, 1),
                                      width: 1.5),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  studentName = val;
                                });
                              }),
                          TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter Number' : null,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.numbers_sharp,
                                  color: Color.fromRGBO(78, 138, 186, 1),
                                ),
                                labelText: 'Register Number',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(0, 45, 77, 1)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(9, 83, 145, 1),
                                      width: 1.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(78, 138, 186, 1),
                                      width: 1.5),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  studentNumber = val;
                                });
                              }),
                          DropdownButtonFormField(
                            validator: (val) {
                              if (val == null) {
                                return "Choose your department";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.bookmark_outline,
                                color: Color.fromRGBO(78, 138, 186, 1),
                              ),
                              labelText: 'Department',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(0, 45, 77, 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(9, 83, 145, 1),
                                    width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(78, 138, 186, 1),
                                    width: 1.5),
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
                                child: Text(
                                    "Electronics & Communication Engineering"),
                                value: "ECE",
                              ),
                              DropdownMenuItem(
                                child: Text("Civil Engineering"),
                                value: "CIVIL",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                    "Electrical & Electronics Engineering"),
                                value: "EEE",
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                studentDept = val.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 10.0),
                          DropdownButtonFormField(
                            validator: (val) {
                              if (val == null) {
                                return "Choose your department";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.route,
                                color: Color.fromRGBO(78, 138, 186, 1),
                              ),
                              labelText: 'Select Route',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(0, 45, 77, 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(9, 83, 145, 1),
                                    width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(78, 138, 186, 1),
                                    width: 1.5),
                              ),
                            ),
                            items: routesID,
                            onChanged: (val) {
                              var result =
                                  attendanceDB.getStops(val.toString());
                              result.then((value) => {
                                    StopList = (value as List),
                                    for (int i = 0; i < StopList.length; i++)
                                      {
                                        StopDropDown.add(DropdownMenuItem(
                                          child: Text(StopList[i]['stopName']
                                              .toString()),
                                          value: StopList[i]['stopName']
                                              .toString(),
                                        ))
                                        // if(FacultyList[i]['assigned_role'].toString() == ' '){

                                        // }
                                      }
                                  });
                              setState(() {
                                studentRoute = val.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 20.0),
                          DropdownButtonFormField(
                            validator: (val) {
                              if (val == null) {
                                return "Choose your department";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.route,
                                color: Color.fromRGBO(78, 138, 186, 1),
                              ),
                              labelText: 'Select Stop',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(0, 45, 77, 1)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(9, 83, 145, 1),
                                    width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(78, 138, 186, 1),
                                    width: 1.5),
                              ),
                            ),
                            items: StopDropDown,
                            onChanged: (val) {
                              setState(() {
                                studentStop = val.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(35, 123, 196, 1),
                                padding:
                                    const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                            onPressed: () async {
                              _setDetails();
                              dynamic result = await attendanceDB.createStudent(
                                  studentName,
                                  studentDept,
                                  studentNumber,
                                  studentRoute,
                                  studentStop);
                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(result.toString()));
                                Navigator.popAndPushNamed(
                                    context, "/student-assign");
                              }

                              // if (_formkey.currentState!.validate()) {

                              //   // dynamic result = await _auth.register(email, password, name, role, dept, regno);
                              //   // if (result != null) {
                              //   //   ScaffoldMessenger.of(context).showSnackBar(getSnackBar(result.message.toString()));
                              //   // }
                              // }
                            },
                            child: const Text(
                              "Create Students",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 2,
                            indent: 1,
                            endIndent: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Text("Loading.......");
            }));
  }
}
