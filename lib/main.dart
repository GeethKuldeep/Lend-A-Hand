import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lendahand/screens/Daily.dart';
import 'package:lendahand/screens/Homescreen.dart';
import 'package:lendahand/screens/Lets.dart';
import 'package:lendahand/screens/Medical.dart';
import 'package:lendahand/screens/Safety.dart';
import 'package:lendahand/screens/SplashScreen.dart';

import 'landing_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id ,
        routes:{
          LandingPage.id:(context)=> LandingPage(),
          Medical.id:(context)=>Medical(),
          SplashScreen.id:(context)=>SplashScreen(),
          Safety.id:(context)=>Safety(),
          Daily.id:(context)=>Daily(),
          Lets.id:(context)=>Lets(),
          HomeScreen.id:(context)=> HomeScreen(),
        }
    );
  }
}

