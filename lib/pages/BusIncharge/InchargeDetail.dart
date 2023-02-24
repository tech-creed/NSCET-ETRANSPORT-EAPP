// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/service.dart';
import '../../services/superAdmin.dart';
import '../../utils/SnackBar.dart';

class BusNews extends StatefulWidget {
  const BusNews({super.key});

  @override
  State<BusNews> createState() => _BusNewsState();
}

class _BusNewsState extends State<BusNews> {
  String? assigned_role = '';
  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];

  String facultyNameHod = '';
  String facultyNameHodDept = '';
  String facultyNameBusIncharge = '';
  String currentNews = '';
  String latestNews = '';
  String? trakerID = '';

  List<DropdownMenuItem<Object>> dacultyDropdownList = [];
  var FacultyList = [];

  ServiceDb service = ServiceDb('');

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    assigned_role = prefs.getString('assigned');
    trakerID = prefs.getString('trakerID');
    print(trakerID);
    dynamic values = await service.getBusNews(trakerID);

    setState(() {
      currentNews = values;
      assigned_role = assigned_role;
    });
  }

  @override
  void initState(){
    _setDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, "Update News", isLogout: true),
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
                    "News Update",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(currentNews),
                  if(assigned_role == 'BusIncharge')...[
                  const SizedBox(height: 40.0),
                    
                    TextFormField(
                  validator: (val) => val!.length < 6
                      ? 'Enter a password with 6+ characters'
                      : null,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.lock_outline,
                      color: Color.fromRGBO(78, 138, 186, 1),
                    ),
                    labelText: 'Update News',
                    labelStyle: TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(9, 83, 145, 1), width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                    ),
                  ),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      latestNews = val;
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
                                  await service.updateNews(trakerID,latestNews);
                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(result.toString()));
                              }
                            },
                            child: const Text(
                              "Update News",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ),
                  ]
                ],
              ),
            ),
          ),
        ));
  }
}
