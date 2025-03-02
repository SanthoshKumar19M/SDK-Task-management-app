import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';

class SideNavBar extends StatelessWidget {
  final bool home;
  final List<String> generalData;

  const SideNavBar({Key? key, required this.home, required this.generalData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              children: _buildMenuItems(),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the sidebar header
  Widget _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Maxwell Engineering",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Task Management",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Dynamically builds the menu items based on the `home` value
  List<Widget> _buildMenuItems() {
    if (home) {
      return [
        _buildMenuItem("Dashboard", Icons.dashboard),
        _buildMenuItem("Scheduled Tasks", Icons.schedule),
        _buildMenuItem("Completed Tasks", Icons.check_circle),
        _buildMenuItem("With-held Tasks", Icons.pause_circle),
      ];
    } else {
      List<Widget> menuItems = [_buildMenuItem("General Data", Icons.data_usage)];
      for (String data in generalData) {
        menuItems.add(_buildMenuItem(data, Icons.school));
      }
      return menuItems;
    }
  }

  /// Helper function to create a menu item
  Widget _buildMenuItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        // Handle navigation here
      },
    );
  }
}
