import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:voting_system/screens/dashboard/adminDashboard/adminMainScreen.dart';
import 'package:voting_system/screens/dashboard/studentDashboard/votingsystem_dashboard.dart';
>>>>>>> fccb6cfd2711144ebf4d57c5dde4fdbac28cc3e2
import 'package:voting_system/screens/votingsystem_login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
<<<<<<< HEAD
        home: const VotingsystemLogin());
=======
        home: Adminsystemdashboard());
>>>>>>> fccb6cfd2711144ebf4d57c5dde4fdbac28cc3e2
  }
}
