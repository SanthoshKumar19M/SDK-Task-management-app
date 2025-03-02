import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatelessWidget {
  final List<String> pathSegments;
  final String userInitial;

  const Header({
    Key? key,
    required this.pathSegments,
    required this.userInitial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If the path is empty or starts with "/", replace the first segment with "Dashboard"
    List<String> updatedSegments = List.from(pathSegments);
    if (updatedSegments.isEmpty || updatedSegments.first.isEmpty) {
      updatedSegments = ["Dashboard", ...updatedSegments.skip(1)];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Breadcrumbs
              Row(
                children: updatedSegments.map((segment) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Text(
                          segment,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (segment != updatedSegments.last) const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // User Profile Button with Popup Menu
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "home") {
                    context.go("/"); // Navigate to Home
                  } else if (value == "settings") {
                    // Do nothing for now (Settings page)
                  } else if (value == "signout") {
                    // Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false); // Sign out and go to Login
                    context.go('/login');
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "home",
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Home"),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "settings",
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "signout",
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Sign Out"),
                    ),
                  ),
                ],
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    userInitial,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(), // Divider at the end
      ],
    );
  }
}
