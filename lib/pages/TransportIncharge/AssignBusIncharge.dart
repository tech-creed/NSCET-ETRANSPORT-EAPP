// ignore_for_file: file_names

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/superAdmin.dart';
import '../../services/busCreate.dart';
import '../../utils/SnackBar.dart';

class AssignIncharge
 extends StatefulWidget {
  const AssignIncharge
({super.key});

  @override
  State<AssignIncharge
> createState() => _AssignInchargeState();
}

class _AssignInchargeState extends State<AssignIncharge
> {
  String? assigned_role = '';
  String busName = '';
  String busNumber = '';

  String trackerID = '';
  String facultyName = '';


  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];

  List<DropdownMenuItem<Object>> dacultyDropdownList = [];
  var FacultyList = [];
  final userRef = FirebaseDatabase.instance.ref('routes');

  BusDB busDB = BusDB('');
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
        appBar: getAppbar(context, "BusIncharge", isLogout: true),
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
            stream: userRef.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              final tilesList = <Widget>[];
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                var i = 0;
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;

                List<DropdownMenuItem<Object>> stopList = [];

                stopList.clear();

                map.forEach(
                  (key, value) {
                    stopList.add(DropdownMenuItem(
                      child: Text(value['routeName'].toString()),
                      value: value['routeID'].toString(),
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
                            "Create Bus",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Times New Roman',
                            ),
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
                                Icons.bookmark_outline,
                                color: Color.fromRGBO(78, 138, 186, 1),
                              ),
                              labelText: 'Select BusIncharge',
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
                            items: dacultyDropdownList,
                            onChanged: (val) {
                              setState(() {
                                facultyName = val.toString();
                              });
                            },
                          ),
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
                              labelText: 'Bus Route',
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
                            items: stopList,
                            onChanged: (val) {
                              setState(() {
                                trackerID = val.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 30.0),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(35, 123, 196, 1),
                                padding:
                                    const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                            onPressed: () async {
                              dynamic result =
                                  await adminDB.assignBusIncharge(facultyName,trackerID);
                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(result.toString()));
                              }
                              // if (_formkey.currentState!.validate()) {

                              //   // dynamic result = await _auth.register(email, password, name, role, dept, regno);
                              //   // if (result != null) {
                              //   //   ScaffoldMessenger.of(context).showSnackBar(getSnackBar(result.message.toString()));
                              //   // }
                              // }
                            },
                            child: const Text(
                              "Assign Bus Incharge",
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
                          const SizedBox(height: 30.0),
                          
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Text("Loading.........");
            }));
  }
}
