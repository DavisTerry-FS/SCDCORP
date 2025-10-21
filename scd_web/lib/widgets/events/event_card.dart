import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import '../../config/theme.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String image;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // We give the card a fixed width to solve the "infinite width" error
    // that occurs when placing it in a horizontal ListView.
    return SizedBox(
      width: 220,
      child: Card(
        color: Colors.grey[900],
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade800),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              // Reducing vertical padding to prevent overflow in the parent ListView.
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(date, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
