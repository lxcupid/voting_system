import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_dashboard.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_election.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_history.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/home/home_admin.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/admin_drawer.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/admin_home_header.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/home_header.dart';

class Adminsystemdashboard extends StatefulWidget {
  const Adminsystemdashboard({super.key});

  @override
  _AdminsystemdashboardState createState() => _AdminsystemdashboardState();
}

class _AdminsystemdashboardState extends State<Adminsystemdashboard> {
  bool isDrawerCollapsed = false;
  String currentScreen = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            width: isDrawerCollapsed ? 70 : 250,
            duration: const Duration(milliseconds: 300),
            child: AdminDrawer(
              isCollapsed: isDrawerCollapsed,
              onMenuPressed: toggleDrawer,
              onScreenSelected: changeScreen,
              currentScreen: currentScreen, // Pass the current screen
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                AdminHomeHeader(
                  onMenuPressed: toggleDrawer,
                  user: 'Admin',
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: getCurrentScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void toggleDrawer() {
    setState(() {
      isDrawerCollapsed = !isDrawerCollapsed;
    });
  }

  void changeScreen(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  Widget getCurrentScreen() {
    switch (currentScreen) {
      case 'Dashboard':
        return DashScreen();
      case 'History':
        return AdminHistory();
      case 'Colleges':
        return AdminElection();
      case 'Home':
        return HomeAdmin();
      default:
        return HomeAdmin();
    }
  }
}
