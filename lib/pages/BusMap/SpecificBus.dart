import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

import '../../services/busLocation.dart';

class SpecificBusTrack extends StatefulWidget {
  const SpecificBusTrack({Key? key}) : super(key: key);

  @override
  State<SpecificBusTrack> createState() => SpecificBusTrackState();
}

class SpecificBusTrackState extends State<SpecificBusTrack> {
  final live_ref = FirebaseDatabase.instance.ref('live');

  BusDB busDB = BusDB('');

  final Set<Marker> markers = new Set(); //markers for google map
  final Set<Polyline> polylines = {}; //poly
  List<LatLng> latLen = [];
  BitmapDescriptor customeIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    getIcons();
    super.initState();
  }

  // Cargar imagen del Marker
  getIcons() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 3.2), "images/marker-re.png")
        .then(
      (icon) {
        setState(() {
          customeIcon = icon;
        });
      },
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.0020, 77.4731),
    zoom: 10,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 0, target: LatLng(10.0020, 77.4731), tilt: 60, zoom: 16.5);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
        body: StreamBuilder(
            stream: live_ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              final tilesList = <Widget>[];
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                var i = 0;
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> location = [];
                List<dynamic> busId = [];

                location.clear();
                markers.clear();
                
                location = map.values.toList();

                map.forEach(
                  (key, value) async {
                    if (key == args[0]) {
                      var long = double.parse(value["longitude"].toString());
                      var lat = double.parse(value["latitude"].toString());

                      markers.add(Marker(
                        //add first marker
                        markerId: MarkerId(key.toString()),
                        position: LatLng(lat, long), //position of marker
                        infoWindow: InfoWindow(
                          //popup info
                          title: key.toString(),
                          snippet:
                              "Speed - ${value["speed"]}km | Satellite - ${value["satellite"]}",
                        ),
                        icon: customeIcon, //Icon for Marker
                      ));

                      final response = await http.get(Uri.parse(
                          'https://nscet-etransport-server.onrender.com/bus/route/' +
                              lat.toString() +
                              '/' +
                              long.toString()));

                      if (response.statusCode == 200) {
                        // If the server did return a 200 OK response,
                        // then parse the JSON.
                        var data = jsonDecode(response.body);
                        // print(data);
                        if(latLen.length == 0){
                            for (var i = 0; i < data.length; i++) {
                            latLen.add(LatLng(data[i][1], data[i][0]));
                          }
                        }
                        
                        polylines.add(Polyline(
                          polylineId: PolylineId('0'),
                          points: latLen,
                          color: Color.fromARGB(255, 39, 134, 212),
                        ));
                      } else {
                        // If the server did not return a 200 OK response,
                        // then throw an exception.
                        throw Exception('Failed to load album');
                      }

                      // if (result.points.isNotEmpty) {
                      //   result.points.forEach((PointLatLng point) {
                      //     polylineCoordinates
                      //         .add(LatLng(point.latitude, point.longitude));
                      //   });
                      // } else {
                      //   print(result.errorMessage);
                      // }
                    }
                  },
                );
                //sleep(Duration(seconds: 5));
                return Scaffold(
                  drawer: const SideBarnav(),
                  appBar: getAppbar(context, "NSCET", isLogout: true),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startFloat,
                  body: GoogleMap(
                    markers: markers, //markers to show on map
                    mapType: MapType.hybrid, //10.030393, 77.505875
                    initialCameraPosition: _kGooglePlex,
                    polylines: polylines, //polylines
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: _goToTheLake,
                    label: const Text('Route'),
                    icon: const Icon(Icons.route),
                  ),
                );
              }
              return Text("Loading.........");
            }));
  }

  // Set<Marker> getmarkers(location, busId) {
  //   //markers to place on map
  //   setState(() {
  //     markers.add(Marker(
  //       //add second marker
  //       markerId: MarkerId("2"),
  //       position: LatLng(10.1020, 77.4631), //position of marker
  //       infoWindow: InfoWindow(
  //         //popup info

  //         title: 'Marker Title Second ',
  //         snippet: 'My Custom Subtitle',
  //       ),
  //       icon: customeIcon, //Icon for Marker
  //     ));

  //     markers.add(Marker(
  //       //add third marker
  //       markerId: MarkerId("3"),
  //       position: LatLng(10.0120, 77.4731), //position of marker
  //       infoWindow: InfoWindow(
  //         //popup info
  //         title: 'Marker Title Third ',
  //         snippet: 'My Custom Subtitle',
  //       ),
  //       icon: customeIcon, //Icon for Marker
  //     ));

  //     //add more markers here
  //   });

  //   return markers;
  // }

  Future<void> _goToTheLake() async {
    setState(() {});
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
