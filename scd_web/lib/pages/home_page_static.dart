import 'package:flutter/material.dart';
import 'package:scd_web/data/models/pillar_model.dart';
import '../widgets/home/pillar_card.dart';
import '../widgets/layout/responsive_layout.dart';

/// Temporary static home page for testing without Firebase
class HomePageStatic extends StatelessWidget {
  const HomePageStatic({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section - Static
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/hero.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  onError: (exception, stackTrace) {
                    // Error handled by fallback
                  },
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Pillars Section - Static
          const PillarsSection(),

          // Upcoming Events - Static Message
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Check back soon for upcoming events!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class PillarsSection extends StatelessWidget {
  const PillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pillars = [
      PillarModel(
        id: '1',
        title: 'DISCIPLINE',
        description:
            'Building character, focus, and a strong work ethic through structured practice and dedication to the craft.',
        image: 'assets/pillar1.png',
        displayOrder: 1,
      ),
      PillarModel(
        id: '2',
        title: 'TEAMWORK',
        description:
            'Collaborating for success, supporting one another, and achieving excellence together as a unified corps.',
        image: 'assets/pillar2.png',
        displayOrder: 2,
      ),
      PillarModel(
        id: '3',
        title: 'ARTISTRY',
        description:
            'Fostering creativity, self-expression, and performance excellence in both drumming and dance.',
        image: 'assets/pillar3.png',
        displayOrder: 3,
      ),
    ];

    final pillarCards = pillars
        .map(
          (pillar) => PillarCard(
            title: pillar.title,
            description: pillar.description,
            image: pillar.image,
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: ResponsiveLayout(
        mobileBody: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: pillarCards
              .expand((card) => [card, const SizedBox(height: 24)])
              .toList()
            ..removeLast(),
        ),
        desktopBody: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pillarCards
              .expand((card) => [card, const SizedBox(width: 24)])
              .toList()
            ..removeLast(),
        ),
      ),
    );
  }
}
