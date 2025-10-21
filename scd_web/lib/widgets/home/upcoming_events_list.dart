import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scd_web/data/models/event_model.dart';
import 'package:scd_web/data/services/firestore_service.dart';
import 'package:scd_web/widgets/events/event_card.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Upcoming Events',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220, // Increased height to accommodate card content
          child: FutureBuilder<List<EventModel>>(
            future: FirestoreService.instance.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No upcoming events.'));
              }

              final events = snapshot.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: EventCard(
                      title: event.title,
                      // Using intl package for nice date formatting
                      date: DateFormat('MMM d, yyyy').format(event.date),
                      image: event.imageUrl,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
