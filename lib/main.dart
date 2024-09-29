import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/core/providers/selected_candidate_provider.dart'; // Import your provider
import 'package:google_fonts/google_fonts.dart';
import 'package:voting_system/screens/dashboard/studentDashboard/votingsystem_dashboard.dart';
import 'package:voting_system/screens/votingsystem_login.dart';
import 'package:voting_system/screens/votingsystem_signup.dart';
import 'package:voting_system/screens/votingsystem_verifyOTP.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => SelectedCandidateProvider()),
        // Add other providers here as needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: VotingsystemLogin(),
    );
  }
}
