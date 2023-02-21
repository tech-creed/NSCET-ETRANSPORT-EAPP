// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarnav extends StatefulWidget {
  const SideBarnav({Key? key}) : super(key: key);

  @override
  _SideBarnavState createState() => _SideBarnavState();
}

class _SideBarnavState extends State<SideBarnav> {
  String? name = '';
  String? role = '';
  String? dept = '';
  String? regno = '';
  String? assigned_role = '';

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    dept = prefs.getString('dept');
    name = prefs.getString('name');
    regno = prefs.getString('regno');
    assigned_role = prefs.getString('assigned');

    setState(() {
      if (role == 'Parent') {
        role = "$dept - $regno";
      } else {
        role = "$dept - Faculty";
      }
    });
  }

  @override
  void initState() {
    _setDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      color: const Color.fromRGBO(245, 245, 245, 1),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
      child: Column(
        children: [
          Container(
            height: 170,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 45, 77, 1),
            ),
            child: Align(
              alignment: FractionalOffset.center,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    "E-TRANSPORT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                      const Icon(
                        Icons.person,
                        color: Color.fromRGBO(240, 240, 240, 1),
                        size: 38.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " " + name.toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          Text(
                            " " + role.toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(235, 171, 81, 1),
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(235, 171, 81, 0.66),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/");
                        },
                        child: const Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          if (assigned_role == 'TransportIncharge') ...[
            ListTile(
              title: const Text(
                "Track My Bus",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                //Navigator.popAndPushNamed(context, "/");
                Navigator.pushNamed(context, "/specificBus",
                    arguments: ['TN-625531']);
              },
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text(
                "Verifing Your Role",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
          ] else if (assigned_role == 'SuperAdmin') ...[
            ListTile(
              title: const Text(
                "Assign HOD / Incharges",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/superior-assign");
              },
            ),
            ListTile(
              title: const Text(
                "Create and Assign Bus",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/bus-assign");
              },
            ),
            ListTile(
              title: const Text(
                "Create Route | Tracker",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/route-tracker");
              },
            ),
            ListTile(
              title: const Text(
                "Add Bus Stop",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/bus-stop");
              },
            ),
            ListTile(
              title: const Text(
                "Track All Bus",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/track-buses");
              },
            ),
          ] else if (assigned_role == 'TransportIncharge') ...[
            ListTile(
              title: const Text(
                "Tracker ID / Bus Details",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/bus-assign");
              },
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text(
                "Create Route",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/route-tracker");
              },
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text(
                "Create Stops",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/bus-stop");
              },
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text(
                "Assign Student / Bus Incharge",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/student-assign");
              },
            ),
          ] else if (assigned_role == 'BusIncharge') ...[
            ListTile(
              title: const Text(
                "Mark Attendance",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "Bus Strength Detail",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "Todays Report",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "Track My Bus",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                //Navigator.popAndPushNamed(context, "/");
                Navigator.pushNamed(context, "/specificBus",
                    arguments: ['TN-625531']);
              },
            ),
          ] else if (assigned_role == 'HOD') ...[
            ListTile(
              title: const Text(
                "Generate Report",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "My Report",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "Bus Incharge Contact",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
          ] else if (assigned_role == 'Faculty' ||
              assigned_role == 'Parent') ...[
            ListTile(
              title: const Text(
                "My Report",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "Bus Incharge Contact",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            ListTile(
              title: const Text(
                "Track My Bus",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                  fontFamily: 'Times New Roman',
                ),
              ),
              onTap: () {
                //Navigator.popAndPushNamed(context, "/");
                Navigator.pushNamed(context, "/specificBus",
                    arguments: ['TN-625531']);
              },
            ),
          ],
          const SizedBox(height: 20.0),
          ListTile(
            title: const Text(
              "About Us",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(27, 27, 27, 1),
                fontFamily: 'Times New Roman',
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, "/");
            },
          ),
          // const SizedBox(height: 20.0),
          // const Expanded(
          //   child: Align(
          //     alignment: FractionalOffset.bottomCenter,
          //     child: Image(
          //       image: AssetImage('images/7thsense.png'),
          //       width: 160,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
