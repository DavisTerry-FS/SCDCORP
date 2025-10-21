import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/theme.dart';
import 'responsive_layout.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: const ResponsiveLayout(
        mobileBody: MobileFooter(),
        desktopBody: DesktopFooter(),
      ),
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
          '© ${DateTime.now().year} Shark City Drum & Dance Corps.\nAll Rights Reserved.',
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
          '© ${DateTime.now().year} Shark City Drum & Dance Corps.\nAll Rights Reserved.',
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
    // TODO: Replace with actual social media URLs
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook),
          onPressed: () => launchUrl(Uri.parse('https://facebook.com')),
        ),
        // Add other social icons like Instagram, Twitter, etc. here
      ],
    );
  }
}
