import 'package:flutter/material.dart';
import '../widgets/home/hero_section.dart';
import '../widgets/home/pillar_card.dart';
import '../widgets/home/upcoming_events_list.dart';
import '../widgets/layout/app_footer.dart';
import '../widgets/layout/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(),
          PillarsSection(),
          UpcomingEventsList(),
          AppFooter(),
        ],
      ),
    );
  }
}

class PillarsSection extends StatelessWidget {
  const PillarsSection({super.key});

  List<Widget> _pillarCards() => [
        const PillarCard(
          title: 'Discipline',
          description: 'Building strong character',
          image: 'assets/pillar1.png',
        ),
        const SizedBox(width: 24, height: 24),
        const PillarCard(
          title: 'Teamwork',
          description: 'Collaborating for success',
          image: 'assets/pillar2.png',
        ),
        const SizedBox(width: 24, height: 24),
        const PillarCard(
          title: 'Artistry',
          description: 'Expressing creativity',
          image: 'assets/pillar3.png',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: ResponsiveLayout(
        mobileBody: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _pillarCards(),
        ),
        desktopBody: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _pillarCards(),
        ),
      ),
    );
  }
}
