import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "We'd love to hear from you. Whether you have a question about our programs, a performance booking inquiry, or want to support our mission, please get in touch.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 40),
                  _buildContactInfo(context),
                  const SizedBox(height: 40),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Subject'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a subject' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                    ),
                    maxLines: 5,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a message' : null,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // TODO: Implement form submission logic (e.g., send email or save to Firestore)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form submitted (simulation)'),
                            ),
                          );
                        }
                      },
                      child: const Text('SEND MESSAGE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _InfoTile(
          icon: Icons.email_outlined,
          text: 'info@sharkcitydrum.com',
          onTap: () => launchUrl(Uri.parse('mailto:info@sharkcitydrum.com')),
        ),
        _InfoTile(
          icon: Icons.phone_outlined,
          text: '(856) 313-0550',
          onTap: () => launchUrl(Uri.parse('tel:856-313-0550')),
        ),
        const _InfoTile(
          icon: Icons.location_on_outlined,
          text: 'Servicing Norfolk, VA',
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _InfoTile({required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
