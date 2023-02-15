// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDB {
  final database = FirebaseDatabase.instance.ref();
  dynamic dept;
  String userId = "";

  AdminDB(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
    });
  }

  Future<Object?> getFaculty() async {
    dynamic adminDb = database.child("/users").orderByChild('role').equalTo("Faculty");
    dynamic value = await adminDb.get();
    return value.value.values.toList();
  }
  Future<String> setHodFacultyRole(String user, String dept) async{
    dynamic userGet = await database.child('/users').orderByChild('user_id').equalTo(user).get();
    dynamic userUpdate = await database.child('/users/'+userGet.value.entries.elementAt(0).key);
    userUpdate.update({"assigned_role":"HOD-"+dept});
    return "HOD Assigned";
  }
  // Future<String> setBusInchargeFacultyRole(String user) async{
  //   dynamic userGet = await database.child('/users').orderByChild('user_id').equalTo(user).get();
  //   dynamic userUpdate = await database.child('/users/'+userGet.value.entries.elementAt(0).key);
  //   userUpdate.update({"assigned_role":"BusIncharge"});
  //   return "BusIncharge Assigned";
  // }
  Future<String> setTransportInchargeFacultyRole(String user) async{
    dynamic userGet = await database.child('/users').orderByChild('user_id').equalTo(user).get();
    dynamic userUpdate = await database.child('/users/'+userGet.value.entries.elementAt(0).key);
    userUpdate.update({"assigned_role":"TransportIncharge"});
    return "TransportIncharge Assigned";
  }
  Future<String> setSuperAdminRole(String user) async{
    dynamic userGet = await database.child('/users').orderByChild('user_id').equalTo(user).get();
    dynamic userUpdate = await database.child('/users/'+userGet.value.entries.elementAt(0).key);
    userUpdate.update({"assigned_role":"SuperAdmin"});
    return "SuperAdmin Assigned";
  }
}
