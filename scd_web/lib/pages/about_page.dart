import 'package:flutter/material.dart';
import 'package:scd_web/data/models/app_content_model.dart';
import 'package:scd_web/data/models/staff_member_model.dart';
import 'package:scd_web/data/services/firestore_service.dart';
import 'package:scd_web/widgets/about/staff_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      // Use Future.wait to fetch both sets of data concurrently for efficiency
      future: Future.wait([
        FirestoreService.instance.getAppContent(),
        FirestoreService.instance.getStaffMembers(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading page: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No content found.'));
        }

        // Safely extract the data
        final AppContentModel content = snapshot.data![0];
        final List<StaffMemberModel> staff = snapshot.data![1];

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ContentSection(
                      title: 'Our Mission',
                      body: content.missionStatement,
                    ),
                    const SizedBox(height: 40),
                    _ContentSection(
                      title: 'Our Vision',
                      body: content.visionStatement,
                    ),
                    const SizedBox(height: 40),
                    _ContentSection(
                      title: 'Our History',
                      body: content.history,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Our Team',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: staff.length,
                      itemBuilder: (context, index) {
                        return StaffCard(staffMember: staff[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContentSection extends StatelessWidget {
  final String title;
  final String body;

  const _ContentSection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        Text(body, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
