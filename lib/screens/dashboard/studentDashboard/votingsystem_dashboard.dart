import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/home_header.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/left_drawer.dart';

class VotingsystemDashboard extends StatefulWidget {
  const VotingsystemDashboard({super.key});

  @override
  _VotingsystemDashboardState createState() => _VotingsystemDashboardState();
}

class _VotingsystemDashboardState extends State<VotingsystemDashboard> {
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
            child: LeftDrawer(
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
                HomeHeader(
                  onMenuPressed: toggleDrawer,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: getCurrentScreen(),
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
      case 'Profile':
        return const Text('Profile Screen');
      case 'Voting Line':
        return const Text('Voting Line Screen');
      case 'Home':
      default:
        return const Text('Home Screen');
    }
  }
}
