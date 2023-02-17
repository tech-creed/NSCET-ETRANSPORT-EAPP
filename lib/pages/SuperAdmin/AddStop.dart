// ignore_for_file: file_names

import 'dart:async';
import 'package:etransport_nscet/services/routeCreate.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/utils/SidebarNav.dart';
import 'package:etransport_nscet/utils/appBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/superAdmin.dart';
import '../../services/busCreate.dart';
import '../../utils/SnackBar.dart';

class AddStop extends StatefulWidget {
  const AddStop({super.key});

  @override
  State<AddStop> createState() => _AssignRouteState();
}

class _AssignRouteState extends State<AddStop> {
  String? assigned_role = '';
  String routerIDKey = '';

  String LatStop = '';
  String LongStop = '';
  String stopName = '';


  final _formkey = GlobalKey<FormState>();
  var tilesList = <Widget>[];
  var TrackerList = [];
  List<DropdownMenuItem<Object>> TrackerDropDown = [];

  final routes_ref = FirebaseDatabase.instance.ref('routes');
  final Set<Marker> markers = new Set(); //markers for google map

  RouteDB routeDB = RouteDB('');

  void _setDetails() async {
    final prefs = await SharedPreferences.getInstance();

    assigned_role = prefs.getString('assigned');
    setState(() {
      assigned_role = assigned_role;
    });
  }

  @override
  void initState() {

  }
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.0020, 77.4731),
    zoom: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarnav(),
        appBar: getAppbar(context, "Create Stops", isLogout: true),
        body: StreamBuilder(
            stream: routes_ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              final tilesList = <Widget>[];
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                var i = 0;
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;

                List<DropdownMenuItem<Object>> routesID = [];

                routesID.clear();

                map.forEach(
                  (key, value) {
                    routesID.add(DropdownMenuItem(
                      child: Text(value['routeName'].toString()),
                      value: key.toString(),
                    ));
                  },
                );
                
                  return Container(child: Column(
                    children: [
                    Container(padding: EdgeInsets.all(5.0),child: Column(children: [const SizedBox(height: 10.0),
                          DropdownButtonFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Choose to Add Stop";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.roundabout_left_outlined,
                        color: Color.fromRGBO(78, 138, 186, 1),
                      ),
                      labelText: 'Select Route',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(9, 83, 145, 1), width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                      ),
                    ),
                    items: routesID,
                    onChanged: (val) {
                      setState(() {
                        routerIDKey = val.toString();
                      });
                    },
                  ),
                  TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter your name' : null,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.stop_circle,
                                  color: Color.fromRGBO(78, 138, 186, 1),
                                ),
                                labelText: 'Stop Name',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(0, 45, 77, 1)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(9, 83, 145, 1),
                                      width: 1.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(78, 138, 186, 1),
                                      width: 1.5),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  stopName = val;
                                });
                              }),
                  const SizedBox(height: 5.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(35, 123, 196, 1),
                        padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                    onPressed: () async {
                      dynamic result =
                                  await routeDB.addStop(LatStop, LongStop, routerIDKey, stopName);
                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(result.toString()));
                              }
                    },
                    child: const Text(
                      "Add Stops",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                    indent: 1,
                    endIndent: 1,
                  ),],),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width, // or use fixed size like 200
                    height: MediaQuery.of(context).size.height / 2,
                    
                    child: GoogleMap(
                    markers: markers,
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onTap: (latLng) {
                      markers.clear();
                      markers.add(Marker(
                      //add first marker
                      markerId: MarkerId("Selected Stop"),
                      position: latLng, //position of marker
                      
                      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                    ));
                        LatStop = latLng.latitude.toString();
                        LongStop = latLng.longitude.toString();
                        setState(() {
         
                        });
                      }
                    ))
                    
                    
                      
                    ])
                    
                    );
              }
              return Text("Loading.........");
            }));
  }
}
