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
    dynamic Db = database.child("/routes/" + route +'/routeID');
    dynamic value = await Db.get();

    DatabaseReference push = busData.push();
    push.set({
      "Name": Name,
      "Dept": Dept,
      "regNo": regNo,
      "trackerID": value.value,
      "Stop": stop
    });
    dynamic userGet = await database.child('/users').orderByChild('regno').equalTo(regNo).get();
    print(userGet.value);
    if(userGet.value != null){
      dynamic userUpdate = await database.child('/users/'+userGet.value.entries.elementAt(0).key);
      dynamic userDB = database.child("/routes/" + route +'/routeName');
      dynamic userValue = await Db.get();
      userUpdate.update({"assigned_role": "Parent", "trackerID":value.value, "stop":stop, "route":userValue.value});
    }
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
