// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';

class StudentDb {
  dynamic dept, className;
  final database = FirebaseDatabase.instance.reference();

  StudentDb({dept, className}) {
    this.dept = dept;
    this.className = className;
  }
  Future addStudentXLSX(listStudents) async {
    final classDb = database.child("/classes/" + dept + "/" + className);

    for (var i = 0; i < listStudents.length; i++) {
      dynamic value = await classDb
          .orderByChild("reg_no")
          .equalTo(listStudents[i][1])
          .once();
      if (value.value == null) {
        classDb.push().set({
          "name": listStudents[i][0].toString().toUpperCase(),
          "reg_no": listStudents[i][1]
        });
      }
    }
    return "ok";
  }

  Future addStudent(stuName, stuRegno, mobile_number) async {
    final classDb = database.child("/classes/" + dept + "/" + className);

    dynamic value =
        await classDb.orderByChild("reg_no").equalTo(stuRegno).once();

    if (value.value == null) {
      classDb
          .push()
          .set({"name": stuName.toString().toUpperCase(), "reg_no": stuRegno});
      return null;
    } else {
      return "Student already exist";
    }
  }

  Stream? getClassStudentsRef() {
    final classDb = database
        .child("/classes/" + dept + "/" + className)
        .orderByChild('name');
    return classDb.onValue;
  }

  void deleteClass(stu_uid) async {
    final classDb =
        database.child("/classes/" + dept + "/" + className + "/" + stu_uid);
    await classDb.remove();
  }
}
