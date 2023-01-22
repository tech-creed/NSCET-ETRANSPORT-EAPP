// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDB {
  final database = FirebaseDatabase.instance.reference();
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

  Stream? setFacultyRole(roles) {
    print(roles);
  }

  void deleteClass(className) async {
    dynamic classDb = database.child("/classes/" + dept + '/classes_list');
    dynamic value = await classDb.get();
    dynamic classList = value.value.toList();
    bool isRemoved = classList.remove(className);
    if (isRemoved) {
      classDb.set(classList);
    }

    classDb = database.child("/classes/" + dept + "/" + className);
    await classDb.remove();
  }
}
