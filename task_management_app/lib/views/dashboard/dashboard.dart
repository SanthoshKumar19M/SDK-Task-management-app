import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management_app/views/task_screens/create_task_screen.dart';
import '../../core/theme.dart'; // Import your theme file
import '../../widgets/side_nav_bar.dart'; // Import the sidebar

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: AppTheme.secondaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_open_outlined, color: Colors.white),
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Menu option comming soon",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: "center",
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CreateTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar for Home
          SideNavBar(isHomeScreen: false, numberOfSchools: 4),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Welcome to the Home Screen!",
                      style: Theme.of(context).textTheme.bodyLarge,
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
}
