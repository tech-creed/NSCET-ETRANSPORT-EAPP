// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, "NSCET AMS", isLogout: true),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(219, 105, 141, 1),
                      ),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.person, size: 100.0),
                        Text(
                          "PROFILE",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(219, 105, 141, 1),
                      ),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/classes");
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.class_, size: 100.0),
                        Text(
                          "CLASSES",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(219, 105, 141, 1),
                      ),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/markAttendence");
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.present_to_all, size: 90.0),
                        Text(
                          "MARK",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        Text(
                          "ATTENDANCE",
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(219, 105, 141, 1),
                      ),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/todayReport");
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.done, size: 100.0),
                        Text(
                          "REPORT",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
