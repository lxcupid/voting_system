import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/voting_navigation_student.dart';

class VotingsystemDashboard extends StatelessWidget {
  const VotingsystemDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Row(
        children: [
          Expanded(
            child: Container(child: StudentNavigation()),
          ),
        ],
      )),
    );
  }
}
