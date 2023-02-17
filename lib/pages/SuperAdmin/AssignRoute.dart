// ignore_for_file: file_names

import 'dart:async';
import 'package:etransport_nscet/services/routeCreate.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/superAdmin.dart';
import '../../services/busCreate.dart';
import '../../utils/SnackBar.dart';

class AssignRoute extends StatefulWidget {
  const AssignRoute({super.key});

  @override
  State<AssignRoute> createState() => _AssignRouteState();
}

class _AssignRouteState extends State<AssignRoute> {
  String? assigned_role = '';
  String routeName = '';
  String stopName = '';
  String trackerName = '';

  String assignTracker = '';
  String assignRoute = '';


  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];
  var TrackerList = [];
  List<DropdownMenuItem<Object>> TrackerDropDown = [];



  List<DropdownMenuItem<Object>> TrackerID = [];
  final routes_ref = FirebaseDatabase.instance.ref('routes');

  RouteDB routeDB = RouteDB('');

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();

    assigned_role = prefs.getString('assigned');
    setState(() {
      assigned_role = assigned_role;
    });
  }

  @override
  void initState() {
    var faculty = routeDB.getTracker();
    faculty.then((value) => {
      _setDetails(),
      TrackerList = (value as List),
      for (int i = 0; i < TrackerList.length; i++)
        {
          TrackerDropDown.add(DropdownMenuItem(
            child: Text(TrackerList[i]['trackerID'].toString()),
            value: TrackerList[i]['trackerID'].toString(),
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
        appBar: getAppbar(context, "Create Routes", isLogout: true),
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
                            "Create Routes",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter name' : null,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.bus_alert_sharp,
                                  color: Color.fromRGBO(78, 138, 186, 1),
                                ),
                                labelText: 'Routes Name',
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
                                  routeName = val;
                                });
                              }),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(35, 123, 196, 1),
                                padding:
                                    const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                            onPressed: () async {
                              dynamic result =
                                  await routeDB.createRoute(routeName);
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
                              "Craete Route",
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
                          Text(
                            "Create Bus Tracker",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter name' : null,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.track_changes,
                                  color: Color.fromRGBO(78, 138, 186, 1),
                                ),
                                labelText: 'Tracker ID',
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
                                  trackerName = val;
                                });
                              }),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(35, 123, 196, 1),
                                padding:
                                    const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                            onPressed: () async {
                              dynamic result =
                                  await routeDB.createTracker(trackerName);
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
                              "Craete Tracker",
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
                          Text(
                            "Assign Bus and Tracker",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          DropdownButtonFormField(
                            validator: (val) {
                              if (val == null) {
                                return "Choose bus";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.bus_alert_rounded,
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
                              setState(() {
                                assignRoute = val.toString();
                              });
                            },
                          ),
                          DropdownButtonFormField(
                            validator: (val) {
                              if (val == null) {
                                return "Choose bus";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.drag_indicator,
                                color: Color.fromRGBO(78, 138, 186, 1),
                              ),
                              labelText: 'Select Tracker',
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
                            items: TrackerDropDown,
                            onChanged: (val) {
                              setState(() {
                                assignTracker = val.toString();
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
                              dynamic result = await routeDB.assignRouteTracker(
                                  assignTracker, assignRoute);
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
                              "Assign Bus Tracker",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ),
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
