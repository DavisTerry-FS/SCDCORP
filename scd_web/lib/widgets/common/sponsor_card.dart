import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scd_web/data/models/sponsor_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorCard extends StatelessWidget {
  final SponsorModel sponsor;

  const SponsorCard({super.key, required this.sponsor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: sponsor.websiteUrl != null
          ? () => launchUrl(Uri.parse(sponsor.websiteUrl!))
          : null,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        constraints: const BoxConstraints(maxWidth: 120, maxHeight: 80),
        child: CachedNetworkImage(
          imageUrl: sponsor.logoUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(color: Colors.grey.shade800),
          errorWidget: (context, url, error) =>
              Icon(Icons.broken_image, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
