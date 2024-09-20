import 'package:flutter/material.dart';

class StudentNavigation extends StatefulWidget {
  @override
  _StudentNavigationState createState() => _StudentNavigationState();
}

class _StudentNavigationState extends State<StudentNavigation> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voting System',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNavigationItem(
                  icon: Icons.home,
                  label: 'Home',
                  index: 0,
                ),
                _buildNavigationItem(
                  icon: Icons.how_to_vote_rounded,
                  label: 'Voting Line',
                  index: 1,
                ),
                _buildNavigationItem(
                  icon: Icons.exit_to_app_rounded,
                  label: 'Logout',
                  index: 2,
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(child: Text('Home Page')),
                Center(child: Text('Voting Line')),
                Center(child: Text('Logout')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        color: _selectedIndex == index ? Colors.white38 : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.green : Colors.black54,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.green : Colors.black54,
                fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
