import 'dart:async';  
import 'package:etransport_nscet/pages/BusIncharge/BusStrength.dart';
import 'package:etransport_nscet/pages/BusIncharge/InchargeDetail.dart';
import 'package:flutter/material.dart';  
import 'package:etransport_nscet/pages/BusMap/AllBus.dart';
import 'package:etransport_nscet/pages/BusMap/SpecificBus.dart';
import 'package:etransport_nscet/pages/SuperAdmin/AddStop.dart';
import 'package:etransport_nscet/pages/SuperAdmin/AssignBus.dart';
import 'package:etransport_nscet/pages/SuperAdmin/AssignRoute.dart';
import 'package:etransport_nscet/pages/SuperAdmin/AssignSuperior.dart';
import 'package:etransport_nscet/pages/TransportIncharge/AssignBusIncharge.dart';
import 'package:etransport_nscet/pages/TransportIncharge/CreateStudent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etransport_nscet/pages/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:etransport_nscet/services/auth.dart';
import 'package:provider/provider.dart';
  
void main() async { 
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  }  

class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: MyHomePage(),  
      debugShowCheckedModeBanner: false,  
    );  
  }  
}  
  
class MyHomePage extends StatefulWidget {  
  @override  
  SplashScreenState createState() => SplashScreenState();  
}  
class SplashScreenState extends State<MyHomePage> {  
  @override  
  void initState() {  
    super.initState();  
    Timer(Duration(seconds: 3),  
            ()=>Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => HomeScreen()  
            )  
         )  
    );  
  }  
  @override  
  Widget build(BuildContext context) {  
    return Container(  
        color: Color.fromARGB(255, 255, 255, 255),  
        child:Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/logo.png"),
          fit: BoxFit.fitWidth,
        ),
      ),)
    );  
  }  
}  
class HomeScreen extends StatelessWidget { 
  const HomeScreen({Key? key}) : super(key: key); 
  @override  
  Widget build(BuildContext context) {  
    return StreamProvider.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: const Wrapper(),
        routes: {
          '/superior-assign': (context) => const AssignSuperior(),
          '/bus-assign': (context) => const AssignBus(),
          '/track-buses': ((context) => const AllBusTrack()),
          '/specificBus': ((context) => const SpecificBusTrack()),
          '/route-tracker': ((context) => const AssignRoute()),
          '/bus-stop': ((context) => const AddStop()),
          '/student-assign': ((context) => const AssignStudent()),
          '/faculty-assign': ((context) => const AssignIncharge()),
          '/bus-strength': ((context) => const BusStrength()),
          '/bus-news': ((context) => const BusNews()),
        },
      ),
    );
  }
}