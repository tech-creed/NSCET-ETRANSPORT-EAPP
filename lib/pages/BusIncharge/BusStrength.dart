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

class BusStrength

 extends StatefulWidget {
  const BusStrength

({super.key});

  @override
  State<BusStrength

> createState() => _BusStrengthState();
}

class _BusStrengthState extends State<BusStrength

> {
  String? assigned_role = '';
  String busName = '';
  String busNumber = '';

  String busTrackID = '';
  String? trackerID = '';

  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];

  List<DropdownMenuItem<Object>> dacultyDropdownList = [];
  var FacultyList = [];
  final buses_ref = FirebaseDatabase.instance.ref('students');

  BusDB busDB = BusDB('');

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    assigned_role = prefs.getString('assigned');
    trackerID = prefs.getString('trackerID');

    setState(() {
      assigned_role = assigned_role;
      trackerID = trackerID;
      print(trackerID);
    });
  }

  @override
  void initState() {
    _setDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, trackerID, isLogout: true),
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
            stream: buses_ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              final tilesList = <Widget>[];
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                var i = 0;
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;

                List<DropdownMenuItem<Object>> busesNumber = [];
                List<DropdownMenuItem<Object>> trackerId = [];

                busesNumber.clear();
                trackerId.clear();

                map.forEach(
                  (key, value) {
                    busesNumber.add(DropdownMenuItem(
                      child: Text(value['busNumber'].toString()),
                      value: key.toString(),
                    ));
                    trackerId.add(DropdownMenuItem(
                      child: Text(value['busNumber'].toString()),
                      value: value['busNumber'].toString(),
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
                                  busName = val;
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
                                  busNumber = val;
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
                                  await busDB.createBus(busName, busNumber);
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
                              "Craete Bus",
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
              return Text("Loading.........");
            }));
  }
}
