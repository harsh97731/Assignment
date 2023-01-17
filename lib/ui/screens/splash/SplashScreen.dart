import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loginsin/ui/screens/home/dash_board.dart';
import 'package:loginsin/ui/screens/authentication/login/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user != null) {
         if(mounted){
           Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                 builder: (context) => const DashBord(),
               ));
         }
        } else {
          if(mounted){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          }
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.ac_unit_outlined,color: Colors.black,size: 100,),
            SizedBox(height: 20,),
            SpinKitWave(
              color: Colors.black,
              size: 30,
            )
          ],
        ),
      ),
    );


  }
}