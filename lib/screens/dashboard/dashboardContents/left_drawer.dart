import 'package:flutter/material.dart';

class LeftDrawer extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback onMenuPressed;
  final Function(String)
      onScreenSelected; // Callback to handle screen selection
  final String currentScreen; // Track the current screen

  const LeftDrawer({
    super.key,
    required this.isCollapsed,
    required this.onMenuPressed,
    required this.onScreenSelected,
    required this.currentScreen, // Accept the current screen
  });

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Menu icon to collapse/expand the drawer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            color: Colors.green,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'icons/plsp_logo1.png',
                height: 50,
                width: 50,
              ),
            ),
          ),

          // Drawer Items with conditional text visibility
          CustomDrawerItem(
            icon: Icons.home,
            text: 'Home',
            isCollapsed: widget.isCollapsed,
            isSelected: widget.currentScreen == 'Home', // Check if selected
            onTap: () {
              widget.onScreenSelected('Home'); // Change to Home screen
            },
          ),
          CustomDrawerItem(
            icon: Icons.account_circle,
            text: 'Voting Line',
            isCollapsed: widget.isCollapsed,
            isSelected:
                widget.currentScreen == 'Voting Line', // Check if selected
            onTap: () {
              widget.onScreenSelected(
                  'Voting Line'); // Change to Voting Line screen
            },
          ),
          const Divider(),
          CustomDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            isCollapsed: widget.isCollapsed,
            isSelected: false,
            onTap: () {
              Navigator.pop(context);
              // Perform logout action
            },
          ),
        ],
      ),
    );
  }
}

class CustomDrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isCollapsed;
  final bool isSelected; // New variable to check if item is selected
  final GestureTapCallback onTap;

  const CustomDrawerItem({
    required this.icon,
    required this.text,
    required this.isCollapsed,
    required this.isSelected, // Accept the isSelected parameter
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected
          ? Colors.green.withOpacity(0.2)
          : Colors.transparent, // Change background color if selected
      child: ListTile(
        leading: Icon(icon, size: 30),
        title:
            isCollapsed ? null : Text(text), // Show text only if not collapsed
        onTap: onTap,
      ),
    );
  }
}
