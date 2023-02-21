// ignore_for_file: file_names

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.ref();

  void loadData2Local() async {
    final userDb = database.child("/users");
    final prefs = await SharedPreferences.getInstance();

    dynamic userDetails = await userDb.orderByChild('user_id').equalTo(_auth.currentUser!.uid).get();
    
    String userId = userDetails.value.entries.elementAt(0).key;
    String role = userDetails.value[userId]['role'];
    String authUserId = userDetails.value[userId]['user_id'];
    String name = userDetails.value[userId]['name'];
    String dept = userDetails.value[userId]['dept'];
    String email = userDetails.value[userId]['email'];
    String regno = userDetails.value[userId]['regno'];
    String assigned = userDetails.value[userId]['assigned_role'];
    String trakerID = userDetails.value[userId]['trakerID'];
    String stop = userDetails.value[userId]['stop'];
    String route = userDetails.value[userId]['route'];
    
    prefs.setString('userId', userId);
    prefs.setString('role', role);
    prefs.setString('authUserId', authUserId);
    prefs.setString('name', name);
    prefs.setString('dept', dept);
    prefs.setString('email', email);
    prefs.setString('regno', regno);
    prefs.setString('assigned', assigned);
    prefs.setString('trakerID', trakerID);
    prefs.setString('stop', stop);
    prefs.setString('route', route);
  }
}
