import 'package:flutter/material.dart';
import '../core/theme.dart'; // Import your theme file

class SideNavBar extends StatelessWidget {
  final bool isHomeScreen;
  final int numberOfSchools; // Used only in Task Commencement screen

  const SideNavBar({Key? key, required this.isHomeScreen, this.numberOfSchools = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Sidebar width
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor, // Sidebar background color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildLogo(),
          const SizedBox(height: 20),
          isHomeScreen ? _buildHomeNavItems() : _buildTaskCommencementNavItems(),
          const Spacer(),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  // **App Logo**
  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(Icons.task, color: Colors.white, size: 28),
          SizedBox(width: 10),
          Text(
            "SDK Tasks",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // **Home Sidebar Navigation Items**
  Widget _buildHomeNavItems() {
    return Column(
      children: [
        _navItem(Icons.schedule, "Scheduled Tasks"),
        _navItem(Icons.check_circle, "Completed Tasks"),
        _navItem(Icons.warning, "With-held Tasks"),
      ],
    );
  }

  // **Task Commencement Sidebar Navigation Items**
  Widget _buildTaskCommencementNavItems() {
    List<Widget> items = [
      _navItem(Icons.data_usage, "General Data"),
    ];

    for (int i = 1; i <= numberOfSchools; i++) {
      items.add(_navItem(Icons.school, "School-$i"));
    }

    return Column(children: items);
  }

  // **Single Sidebar Item**
  Widget _navItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        // TODO: Handle navigation
      },
    );
  }

  // **Logout Button**
  Widget _buildLogoutButton() {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.white),
      title: const Text("Logout", style: TextStyle(color: Colors.white)),
      onTap: () {
        // TODO: Handle logout logic
      },
    );
  }
}
