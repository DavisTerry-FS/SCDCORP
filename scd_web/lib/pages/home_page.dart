import 'package:flutter/material.dart';
import 'package:scd_web/data/models/pillar_model.dart';
import '../widgets/home/hero_section.dart';
import '../data/services/firestore_service.dart';
import '../widgets/home/pillar_card.dart';
import '../widgets/home/upcoming_events_list.dart';
import '../widgets/layout/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [HeroSection(), PillarsSection(), UpcomingEventsList()],
      ),
    );
  }
}

class PillarsSection extends StatelessWidget {
  const PillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: FutureBuilder<List<PillarModel>>(
        future: FirestoreService.instance.getPillars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox.shrink(); // Don't show section if no data
          }

          final pillars = snapshot.data!;
          final pillarCards = pillars
              .map(
                (pillar) => PillarCard(
                  title: pillar.title,
                  description: pillar.description,
                  image: pillar.image,
                ),
              )
              .toList();

          return ResponsiveLayout(
            mobileBody: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  pillarCards
                      .expand((card) => [card, const SizedBox(height: 24)])
                      .toList()
                    ..removeLast(), // Remove last SizedBox
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  pillarCards
                      .expand((card) => [card, const SizedBox(width: 24)])
                      .toList()
                    ..removeLast(), // Remove last SizedBox
            ),
          );
        },
      ),
    );
  }
}
