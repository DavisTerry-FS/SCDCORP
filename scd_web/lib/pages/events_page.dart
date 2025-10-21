import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scd_web/data/models/event_model.dart';
import 'package:scd_web/data/services/firestore_service.dart';
import 'package:scd_web/widgets/events/event_card.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: FirestoreService.instance.getEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No events found.'));
        }

        final events = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.all(24.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 350,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 0.9,
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return EventCard(
              title: event.title,
              date: DateFormat('E, MMM d, yyyy').format(event.date),
              image: event.imageUrl,
            );
          },
        );
      },
    );
  }
}
