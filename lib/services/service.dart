// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:geolocator/geolocator.dart';

class ServiceDb {
  final database = FirebaseDatabase.instance.ref();
  dynamic dept;
  String userId = "";
  String trackerId = "";
  String stop = "";
  String route = "";

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  ServiceDb(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
      trackerId = prefs.getString("trakerID")!;
      stop = prefs.getString("stop")!;
      route = prefs.getString("route")!;
    });
  }

  Future<Object?> getBusNews(String? trakerID) async {
    final routeBd = database.child("/routes");
    dynamic routeDetails = await routeBd
            .orderByChild('routeID')
            .equalTo(route)
            .get();
    final stopBd = database.child("/routes/"+routeDetails.value.entries.elementAt(0).key+'/news');
    var value = await stopBd.get();
    return value.value;
  }

  Future<Object?> getBus() async {
    // print(trackerId);
    dynamic busDb = database.child("/live/"+trackerId);
    dynamic busValue = await busDb.get();

    final routeBd = database.child("/routes");
    dynamic routeDetails = await routeBd
            .orderByChild('routeID')
            .equalTo(route)
            .get();

    final stopBd = database.child("/routes/"+routeDetails.value.entries.elementAt(0).key+'/stops');
    dynamic stopLocation = await stopBd.get();

    for (var i = 0; i < stopLocation.value.values.toList().length; i++) {
      if(stopLocation.value.values.toList()[i]['stopName'] == stop){

      dynamic distance = calculateDistance(double.parse(busValue.value['latitude']),
        double.parse(busValue.value['longitude']),
        double.parse(stopLocation.value.values.toList()[i]['lat']),
        double.parse(stopLocation.value.values.toList()[i]['long']));
      
        dynamic hour = distance / 35;
        dynamic min = hour * 60;

        hour = hour.toStringAsFixed(0);
        min = min.toStringAsFixed(2);
        distance = distance.toStringAsFixed(3);
        return [distance,hour,min, route, stop];
      };

    }


    
    //print(value.value.values.toList());
    //return busValue.value.values.toList();
  }
 Future<String> updateNews(String? trakerID, String latestNews) async{
    final routeBd = database.child("/routes");
    dynamic routeDetails = await routeBd
            .orderByChild('routeID')
            .equalTo(route)
            .get();
    final stopBd = database.child("/routes/"+routeDetails.value.entries.elementAt(0).key);
    stopBd.update({"news":latestNews});

    return "Updated";
  }
}
