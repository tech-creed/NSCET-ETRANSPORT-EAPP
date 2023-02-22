// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusDB {
  final database = FirebaseDatabase.instance.reference();
  dynamic dept;
  String userId = "";

  BusDB(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
    });
  }

  Stream? getLiveLocation() {
    final busDB = database.child("/live");
    return busDB.onValue;
  }

  Stream? setFacultyRole(roles) {
    print(roles);
  }

  // void deleteClass(className) async {
  //   dynamic classDb = database.child("/classes/" + dept + '/classes_list');
  //   dynamic value = await classDb.get();
  //   dynamic classList = value.value.toList();
  //   bool isRemoved = classList.remove(className);
  //   if (isRemoved) {
  //     classDb.set(classList);
  //   }

  //   classDb = database.child("/classes/" + dept + "/" + className);
  //   await classDb.remove();
  // }
}
