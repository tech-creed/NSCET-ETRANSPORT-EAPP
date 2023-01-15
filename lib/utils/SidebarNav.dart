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
  String? name;
  String? role;
  String? dept = '';

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
      dept = prefs.getString('dept');
      if (role == 'CI') {
        role = dept! + " - Class Incharge";
      } else {
        role = dept! + " - HOD";
      }
      name = prefs.getString('name');
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
              color: Color.fromRGBO(199, 68, 109, 1),
            ),
            child: Align(
              alignment: FractionalOffset.center,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    "NSCET AMS",
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
                          Navigator.popAndPushNamed(context, "/profile");
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
          ListTile(
            title: const Text(
              "Classes",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(27, 27, 27, 1),
                fontFamily: 'Times New Roman',
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, "/classes");
            },
          ),
          const SizedBox(height: 20.0),
          ListTile(
            title: const Text(
              "Mark Attendence",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(27, 27, 27, 1),
                fontFamily: 'Times New Roman',
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, "/markAttendence");
            },
          ),
          const SizedBox(height: 20.0),
          ListTile(
            title: const Text(
              "Report",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(27, 27, 27, 1),
                fontFamily: 'Times New Roman',
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, "/todayReport");
            },
          ),
          const SizedBox(height: 20.0),
          ListTile(
            title: const Text(
              "About",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(27, 27, 27, 1),
                fontFamily: 'Times New Roman',
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, "/about");
            },
          ),
          const SizedBox(height: 20.0),
          const Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Image(
                image: AssetImage('images/7thsense.png'),
                width: 160,
              ),
            ),
          )
        ],
      ),
    );
  }
}
