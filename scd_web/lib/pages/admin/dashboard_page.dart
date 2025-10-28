import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scd_web/data/services/auth_service.dart';
import 'package:scd_web/data/services/firestore_service.dart';
import 'package:scd_web/utils/seed_data.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool _isSeeding = false;
  String _statusMessage = '';

  Future<void> _seedDatabase() async {
    setState(() {
      _isSeeding = true;
      _statusMessage = 'Seeding database...';
    });

    try {
      await FirestoreSeedData.seedAllData();
      if (mounted) {
        setState(() {
          _statusMessage = 'Database seeded successfully!';
          _isSeeding = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database seeded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _statusMessage = 'Error seeding database: $e';
          _isSeeding = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<Map<String, int>> _getCollectionCounts() async {
    try {
      final counts = <String, int>{};
      final db = FirestoreService.instance;

      await db.getAppContent();
      counts['App Content'] = 1;

      final staff = await db.getStaffMembers();
      counts['Staff Members'] = staff.length;

      final events = await db.getEvents();
      counts['Events'] = events.length;

      final pillars = await db.getPillars();
      counts['Pillars'] = pillars.length;

      final sponsors = await db.getSponsors();
      counts['Sponsors'] = sponsors.length;

      final gallery = await db.getGalleryItems();
      counts['Gallery Items'] = gallery.length;

      return counts;
    } catch (e) {
      return {};
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Admin!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your SCD web application content',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),

                // Database Stats Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.storage,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Database Overview',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        FutureBuilder<Map<String, int>>(
                          future: _getCollectionCounts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError || !snapshot.hasData) {
                              return const Text('Error loading database stats');
                            }

                            final counts = snapshot.data!;
                            if (counts.isEmpty) {
                              return const Text('No data found in database');
                            }

                            return Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: counts.entries.map((entry) {
                                return SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: Text(entry.key),
                                    trailing: Text(
                                      '${entry.value}',
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Database Seeding Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Database Seeding',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Populate the database with sample data for testing. '
                          'This will add staff members, events, pillars, sponsors, and gallery items.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        if (_statusMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              _statusMessage,
                              style: TextStyle(
                                color: _statusMessage.contains('Error')
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ),
                        ElevatedButton.icon(
                          onPressed: _isSeeding ? null : _seedDatabase,
                          icon: _isSeeding
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.add_circle_outline),
                          label: Text(_isSeeding ? 'Seeding...' : 'Seed Database'),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Quick Actions Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.quick_contacts_mail,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Quick Actions',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                // Navigate to contact submissions
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Contact submissions feature coming soon'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.mail),
                              label: const Text('View Contact Submissions'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Event management feature coming soon'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.event),
                              label: const Text('Manage Events'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Gallery management feature coming soon'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Manage Gallery'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
