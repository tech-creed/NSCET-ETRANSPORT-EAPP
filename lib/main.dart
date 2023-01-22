import 'package:etransport_nscet/pages/BusMap/AllBus.dart';
import 'package:etransport_nscet/pages/SuperAdmin/AssignSuperior.dart';
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
          '/superior-assign': (context) => const AssignSuperior(),
          '/track-buses': ((context) => const AllBusTrack()),
        },
      ),
    );
  }
}

// body: StreamBuilder(stream: adminDB.getFaculty(),builder: (context, snapshot) {
        //   final tilesList = <Widget>[];

        //   if (snapshot.hasData && !snapshot.hasError && snapshot.data != null) {
        //     final contents = (snapshot.data as DatabaseEvent).snapshot.value;
        //     print(contents);
        //     // if (contents != null) {
        //     //   for (int i = 0; i < contents.length; i++) {
        //     //     tilesList.add(
        //     //       const Divider(
        //     //         height: 20,
        //     //         thickness: 2,
        //     //         indent: 1,
        //     //         endIndent: 1,
        //     //       ),
        //     //     );
        //     //   }
        //     // } else {
              
        //     // }
        //   }
        //   return ListView(
        //     padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        //     children: tilesList,
        //   );
        // }),