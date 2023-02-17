import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../services/busLocation.dart';

class AllBusTrack extends StatefulWidget {
  const AllBusTrack({Key? key}) : super(key: key);

  @override
  State<AllBusTrack> createState() => AllBusTrackState();
}

class AllBusTrackState extends State<AllBusTrack> {
  final live_ref = FirebaseDatabase.instance.ref('live');

  BusDB busDB = BusDB('');

  final Set<Marker> markers = new Set(); //markers for google map
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
      bearing: 0, target: LatLng(10.0020, 77.4731), tilt: 60, zoom: 10);

  @override
  Widget build(BuildContext context) {
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
                  (key, value) {
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
                  },
                );

                return Scaffold(
                  drawer: const SideBarnav(),
                  appBar: getAppbar(context, "NSCET", isLogout: true),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startFloat,
                  body: GoogleMap(
                    markers: markers, //markers to show on map
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: _goToTheLake,
                    label: const Text('Track Bus'),
                    icon: const Icon(Icons.bus_alert),
                  ),
                );
              }
              return Text("Loading.........");
            }));
  }

  Set<Marker> getmarkers(location, busId) {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add second marker
        markerId: MarkerId("2"),
        position: LatLng(10.1020, 77.4631), //position of marker
        infoWindow: InfoWindow(
          //popup info

          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: customeIcon, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId("3"),
        position: LatLng(10.0120, 77.4731), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: customeIcon, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
