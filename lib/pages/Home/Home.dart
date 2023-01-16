// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapSample extends StatefulWidget {
//   const MapSample({Key? key}) : super(key: key);

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(76.00796133580664, 10.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(10.0020, 77.4731),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

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
