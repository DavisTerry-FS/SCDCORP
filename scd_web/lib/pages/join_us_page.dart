import 'package:flutter/material.dart';
import 'package:scd_web/data/models/app_content_model.dart';
import 'package:scd_web/data/services/firestore_service.dart';

class JoinUsPage extends StatelessWidget {
  const JoinUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppContentModel>(
      future: FirestoreService.instance.getAppContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          // Fallback to placeholder text if Firestore data isn't available
          return _buildContent(
            context,
            title: 'Become a Part of the Rhythm',
            body:
                'Information about auditions, volunteer opportunities, and how to become a part of the Shark City family will be available here soon. Stay tuned!',
          );
        }

        final content = snapshot.data!;
        return _buildContent(
          context,
          title: content.joinUsTitle,
          body: content.joinUsText,
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              Text(body, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
