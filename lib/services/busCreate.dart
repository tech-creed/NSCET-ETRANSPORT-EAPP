// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusDB {
  final database = FirebaseDatabase.instance.ref();
  dynamic dept;
  String userId = "";

  BusDB(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
    });
  }

  Future<String> createBus(String busName, String busNumber) async {
    dynamic busData = database.child('/buses');
    DatabaseReference push = busData.push();
    push.set({
      "busName": busName,
      "busNumber": busNumber,
      "busTrackerID": busNumber
    });
    return "Bus Added";
  }

  Future<String> assignTracker(String busID, String trackerId) async {
    print(busID + trackerId);
    dynamic busData = database.child('/buses/' + busID);
    busData.update({"busTrackerID": trackerId});
    return "Tracker Assigned";
  }
}
