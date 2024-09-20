import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/votingsystem_dashboard.dart';
import 'package:voting_system/screens/votingsystem_login.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: VotingsystemLogin());
  }
}
