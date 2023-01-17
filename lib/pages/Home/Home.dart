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
        appBar: getAppbar(context, "NSCET", isLogout: true),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.map, color: Colors.white, size: 29,),
          backgroundColor: Color.fromRGBO(0, 45, 77, 1),
          tooltip: 'Your Bus Map',
          elevation: 5,
          splashColor: Color.fromARGB(255, 33, 118, 175),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        
        body: SingleChildScrollView(child: Stack(children: [
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
                      Navigator.pushNamed(context, "/");
                    },
                    child: Row(
                      children: [
                        const Expanded(child: Icon(Icons.bus_alert_outlined, size: 70.0)),
                        Expanded(child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          RichText(text: const TextSpan(
                              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                              children: <TextSpan>[
                                TextSpan(text: 'Status : '),
                                TextSpan(text: 'Online', style: TextStyle(color: Color.fromARGB(255, 33, 243, 61)))
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
                        
                      ],
                    ),
                  ),
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
                        Color.fromARGB(255, 7, 90, 150),
                      ),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/");
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.class_, size: 100.0),
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
                      children: const [
                        Icon(Icons.call, size: 80.0),
                        Text(
                          "Bus Incharge",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Padding(padding: EdgeInsets.all(10)),
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
                      children: const [
                        Icon(Icons.map_rounded, size: 100.0),
                        Text(
                          "Bus Track",
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
        ]),)
         );
  }
}
