// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceDB {
  final database = FirebaseDatabase.instance.ref();
  dynamic dept;
  String userId = "";

  AttendanceDB(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
    });
  }

  Future<String> createStudent(
      String Name, String Dept, String regNo, String route, String stop) async {
    dynamic busData = database.child('/students');
    DatabaseReference push = busData.push();
    push.set({
      "Name": Name,
      "Dept": Dept,
      "regNo": regNo,
      "trackerID": route,
      "Stop": stop
    });
    return "Student Added";
  }

  Future<Object?> getStops(id) async {
    dynamic Db = database.child("/routes/" + id + '/stops');
    dynamic value = await Db.get();
    return value.value.values.toList();
  }

  Future<String> assignStudentTracker(
      String user, String regNo, String trackerId) async {
    dynamic userGet = await database
        .child('/users')
        .orderByChild('user_id')
        .equalTo(user)
        .get();
    dynamic userUpdate = await database
        .child('/users/' + userGet.value.entries.elementAt(0).key);
    userUpdate.update({"trackerId": "trackerId"});
    return "Tracker Assigned";
  }
}
