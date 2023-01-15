// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassDB {
  final database = FirebaseDatabase.instance.reference();
  dynamic dept;
  String userId = "";

  ClassDB(this.dept) {
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString("userId")!;
    });
  }

  Future addClass(classname) async {
    final classDb = database.child("/classes/" + dept + '/classes_list');
    bool isUnique;

    dynamic value = await classDb.get();
    dynamic classList = value.value;

    if (classList != null) {
      if (classList.contains(classname)) {
        isUnique = false;
      } else {
        isUnique = true;
      }

      if (isUnique) {
        classDb.set(value.value + [classname]);
        return null;
      } else {
        return "Class already exist";
      }
    } else {
      classDb.set([classname]);
    }
  }

  Stream? getselectedClassListRef() {
    final classDb = database.child("/users/" + userId + '/classes');
    return classDb.onValue;
  }

  Stream? getClassListRef() {
    final classDb = database.child("/classes/" + dept + '/classes_list');
    return classDb.onValue;
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
