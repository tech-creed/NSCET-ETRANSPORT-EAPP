import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/pages/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:etransport_nscet/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: const Wrapper(),
        routes: {
          // '/route': (context) => const RouteClasss(),
        },
      ),
    );
  }
}
