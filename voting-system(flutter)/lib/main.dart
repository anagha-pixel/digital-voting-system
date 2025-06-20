import 'package:flutter/material.dart';
import 'package:votting_systems/presenation/admin.dart';
import 'package:votting_systems/presenation/candidatemanagementscreen.dart';
import 'package:votting_systems/presenation/organizerhomescreen.dart';
import 'package:votting_systems/presenation/result.dart';
import 'package:votting_systems/presenation/signup.dart';
import 'package:votting_systems/presenation/viewcandidate.dart';
import 'package:votting_systems/presenation/viewvoters.dart';
import 'package:votting_systems/presenation/voterhomescreen.dart';
import 'package:votting_systems/presenation/votingpage.dart';
import 'package:votting_systems/presenation/signinscreen.dart';
import 'package:votting_systems/presenation/voterregistration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

