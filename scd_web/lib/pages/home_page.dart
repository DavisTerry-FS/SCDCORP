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

  // Static fallback pillars - always shown even without Firebase
  static final List<PillarModel> _staticPillars = [
    PillarModel(
      id: 'static_1',
      title: 'DISCIPLINE',
      description:
          'Building character, focus, and a strong work ethic through structured practice and dedication to the craft.',
      image: 'assets/pillar1.png',
      displayOrder: 1,
    ),
    PillarModel(
      id: 'static_2',
      title: 'TEAMWORK',
      description:
          'Collaborating for success, supporting one another, and achieving excellence together as a unified corps.',
      image: 'assets/pillar2.png',
      displayOrder: 2,
    ),
    PillarModel(
      id: 'static_3',
      title: 'ARTISTRY',
      description:
          'Fostering creativity, self-expression, and performance excellence in both drumming and dance.',
      image: 'assets/pillar3.png',
      displayOrder: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: FutureBuilder<List<PillarModel>>(
        future: FirestoreService.instance.getPillars(),
        builder: (context, snapshot) {
          // Use Firestore data if available, otherwise use static data
          final pillars = (snapshot.hasData && snapshot.data!.isNotEmpty)
              ? snapshot.data!
              : _staticPillars;

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
              children: pillarCards
                  .expand((card) => [card, const SizedBox(height: 24)])
                  .toList()
                ..removeLast(), // Remove last SizedBox
            ),
            desktopBody: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pillarCards
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
