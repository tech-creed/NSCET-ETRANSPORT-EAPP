// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteDB {
  final database = FirebaseDatabase.instance.ref();
  dynamic dept;
  String userId = "";

  RouteDB(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
    });
  }

  Future<String> assignRouteTracker(String assignRoute, String assignTracker) async {
    dynamic busData = database.child('/routes/' + assignTracker);
    busData.update({"routeID": assignRoute});
    return "Bus Tracker Assigned";
  }

  Future<String> createRoute(String routeName) async {
    dynamic routeData = database.child('/routes');
    DatabaseReference push = routeData.push();
    push.set({
      "routeID": " ",
      "routeName":routeName,
    });
    return "Route Added";
  }
  Future<Object?> getTracker() async {
    dynamic trackerDb = database.child("/trackers");
    dynamic value = await trackerDb.get();
    return value.value.values.toList();
  }
   Future<String> createTracker(String trackerName) async {
    dynamic routeData = database.child('/trackers');
    DatabaseReference push = routeData.push();
    push.set({
      "trackerID": trackerName,
    });
    return "Route Added";
  }

  Future<String> assignTracker(String busID, String trackerId) async {
    dynamic busData = database.child('/buses/' + busID);
    busData.update({"busTrackerID": trackerId});
    return "Tracker Assigned";
  }

  Future<String> addStop(String lat, String long, String routeId, String stopName) async {
    dynamic busData = database.child('/routes/' + routeId+'/stops');
    DatabaseReference push = busData.push();
    push.set({
        "lat": lat,
        "long": long,
        "routeKey": routeId,
        "stopName": stopName
      });
    return "Stop Added";
  }

}
