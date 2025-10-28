import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/theme.dart';
import 'responsive_layout.dart';
import 'package:scd_web/data/services/firestore_service.dart';
import 'package:scd_web/widgets/common/sponsor_card.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          const SponsorsSection(),
          const SizedBox(height: 32),
          const ResponsiveLayout(
            mobileBody: MobileFooter(),
            desktopBody: DesktopFooter(),
          ),
        ],
      ),
    );
  }
}

class SponsorsSection extends StatelessWidget {
  const SponsorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Our Sponsors & Partners',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        FutureBuilder(
          future: FirestoreService.instance.getSponsors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error loading sponsors: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No sponsors found.');
            }
            final sponsors = snapshot.data!;
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: sponsors
                  .map((sponsor) => SponsorCard(sponsor: sponsor))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '© ${DateTime.now().year} Shark City Drum & Dance Corps. All Rights Reserved. A 501(c)(3) Non-Profit Organization. Servicing Norfolk, VA.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SocialMediaLinks(),
      ],
    );
  }
}

class MobileFooter extends StatelessWidget {
  const MobileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SocialMediaLinks(),
        const SizedBox(height: 24),
        Text(
          '© ${DateTime.now().year} Shark City Drum & Dance Corps. All Rights Reserved. A 501(c)(3) Non-Profit Organization. Servicing Norfolk, VA.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook),
          tooltip: 'Facebook',
          onPressed: () => launchUrl(
            Uri.parse('https://www.facebook.com/sharkcitydrum'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.mail_outline),
          tooltip: 'Email',
          onPressed: () => launchUrl(
            Uri.parse('mailto:info@sharkcitydrum.com'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.phone),
          tooltip: 'Phone',
          onPressed: () => launchUrl(
            Uri.parse('tel:856-313-0550'),
          ),
        ),
      ],
    );
  }
}
