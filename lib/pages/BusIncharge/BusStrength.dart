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

    setState(() {
    });
  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final tilesList = <Widget>[];
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, args[0], isLogout: true),
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
                var countStudent = 0;
                map.forEach(
                  (key, value) {
                    countStudent += 1;
                    if(value['trackerID'] == args[0]){
                      tilesList.add(ListTile(
                    tileColor: Color.fromRGBO(0, 45, 77, 0.35),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value['Name'],
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              value['regNo'],
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              value['Stop'],
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        
                      ],
                    )));
                      tilesList.add(
                        const Divider(
                          height: 20,
                          thickness: 2,
                          indent: 1,
                          endIndent: 1,
                        ),
                        
                      );
                    }
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
                tilesList.insert(0,ListTile(
                title: Padding(
                  padding: EdgeInsets.fromLTRB(2, 8, 2, 8),
                  child: Text(
                    "Total number of students : " + countStudent.toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ));
                return ListView(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 80),
                  children: tilesList,
                );
              }
              return Text("Loading.........");
            }));
  }
}
