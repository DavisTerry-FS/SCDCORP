import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  // TODO: Replace with your actual donation link from a service like PayPal, Stripe, etc.
  final String _donationUrl = 'https://www.paypal.com/donate';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Support Our Mission',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Your generous contribution empowers youth through the arts, providing them with discipline, teamwork, and a creative outlet. Every donation helps us provide instruments, uniforms, and instruction. Thank you for making a difference!',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => launchUrl(Uri.parse(_donationUrl)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                  ),
                  child: const Text('Donate Now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
