import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_constants.dart';
import 'app_header.dart';
import 'app_footer.dart'; // Import the AppFooter

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: child,
      endDrawer: const AppDrawer(),
      // Add the AppFooter to the bottom of the Scaffold
      bottomNavigationBar: const AppFooter(),
    );
  }
}

// ... (AppDrawer remains the same)
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text(
              'SCD',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...navItems.map(
            (item) => ListTile(
              title: Text(item.label),
              onTap: () {
                context.go(item.route);
                Navigator.pop(context); // Close the drawer
              },
            ),
          ),
        ],
      ),
    );
  }
}
