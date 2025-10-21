import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_constants.dart';
import 'app_header.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: child,
      endDrawer: const AppDrawer(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'SCD',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...navItems.map((item) => ListTile(
                title: Text(item.label),
                onTap: () {
                  context.go(item.route);
                  Navigator.pop(context); // Close the drawer
                },
              )),
        ],
      ),
    );
  }
}
