import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scd_web/data/services/auth_service.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authService.signOut(),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome, Admin! Content management UI will go here.'),
      ),
    );
  }
}
