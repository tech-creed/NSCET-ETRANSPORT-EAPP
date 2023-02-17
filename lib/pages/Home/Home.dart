// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? assigned_role = '';

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    assigned_role = prefs.getString('assigned');
    print(assigned_role);
    setState(() {
      assigned_role = assigned_role;
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
        appBar: getAppbar(context, "NSCET", isLogout: true),
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
          child: Stack(children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 560,
                  height: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(209, 204, 137, 43),
                      ),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/");
                    },
                    child: Row(
                      children: [
                        if (assigned_role == ' ') ...[
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Welcome, Role Verification in Process. Please wait !!",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ]),
                          )
                        ] else if (assigned_role == 'SuperAdmin') ...[
                          const Expanded(
                              child:
                                  Icon(Icons.admin_panel_settings, size: 65.0)),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Welcome, Super Admin !!",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ]),
                          )
                        ] else if (assigned_role == 'Faculty' ||
                            assigned_role == 'Parent' ||
                            assigned_role == 'HOD' ||
                            assigned_role == 'BusIncharge') ...[
                          const Expanded(
                              child:
                                  Icon(Icons.bus_alert_outlined, size: 65.0)),
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 25),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Status : '),
                                        TextSpan(
                                            text: 'Online',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 33, 243, 61)))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  const Text(
                                    "Stop : Muthu Nagar",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(height: 10.0),
                                  const Text(
                                    "Arrivies In : 10 min",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ]),
                          )
                        ] else if (assigned_role == 'TransportIncharge') ...[
                          const Expanded(
                              child: Icon(Icons.person_pin_circle_outlined,
                                  size: 65.0)),
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10.0),
                                  const Text(
                                    "Active Bus : 12",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(height: 10.0),
                                  const Text(
                                    "Tap to Locate Bus",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ]),
                          )
                        ] else ...[
                          const Expanded(
                              child: Icon(
                                  Icons
                                      .signal_cellular_connected_no_internet_0_bar_rounded,
                                  size: 65.0)),
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10.0),
                                  const Text(
                                    "Network Error",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Tap to Refresh',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 243, 33, 33)))
                                      ],
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
                if (assigned_role == ' ')
                  ...[]
                else if (assigned_role == 'SuperAdmin')
                  ...[]
                else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (assigned_role == 'Faculty' ||
                          assigned_role == 'Parent' ||
                          assigned_role == 'HOD') ...[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.class_, size: 65.0),
                                Text(
                                  "My Report",
                                  style: TextStyle(fontSize: 25.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.call, size: 65.0),
                                Text(
                                  "Bus Incharge",
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else if (assigned_role == 'BusIncharge') ...[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.person, size: 65.0),
                                Text(
                                  "Mark Attendance",
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else if (assigned_role == 'TransportIncharge') ...[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.route, size: 65.0),
                                Text(
                                  "Bus & Route",
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.bus_alert_sharp, size: 65.0),
                                Text(
                                  "Bus Tracker ID",
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Padding(padding: EdgeInsets.all(10)),
                      if (assigned_role == 'HOD') ...[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.done, size: 65.0),
                                Text(
                                  "Generate Report",
                                  style: TextStyle(fontSize: 25.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ] else if (assigned_role == 'BusIncharge') ...[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.done, size: 65.0),
                                Text(
                                  "Today Report",
                                  style: TextStyle(fontSize: 25.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (assigned_role == 'BusIncharge' ||
                          assigned_role == 'Faculty' ||
                          assigned_role == 'Parent' ||
                          assigned_role == 'HOD') ...[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 90, 150),
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.map_rounded, size: 65.0),
                                Text(
                                  "Track Bus",
                                  style: TextStyle(fontSize: 25.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ]
              ],
            )
          ]),
        ));
  }
}
