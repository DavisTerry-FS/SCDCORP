import 'package:flutter/material.dart';
import '../events/event_card.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Assuming dark theme
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                EventCard(
                  title: 'Summer Camp',
                  date: 'July 1–30',
                  image: 'assets/event1.png',
                ),
                SizedBox(width: 16),
                EventCard(
                  title: 'Annual Showcase',
                  date: 'August 15',
                  image: 'assets/event2.png',
                ),
                SizedBox(width: 16),
                EventCard(
                  title: 'Fall Benefit',
                  date: 'November 7',
                  image: 'assets/event3.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
