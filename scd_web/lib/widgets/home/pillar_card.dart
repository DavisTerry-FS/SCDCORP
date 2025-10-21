import 'package:flutter/material.dart';
import '../../config/theme.dart';

class PillarCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const PillarCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Image.asset(image, height: 120),
          const SizedBox(height: 16),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
