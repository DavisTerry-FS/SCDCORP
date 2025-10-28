import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scd_web/data/services/firestore_service.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await FirestoreService.instance.submitContactForm(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you! Your message has been sent.'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the form
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending message: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
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
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(labelText: 'Subject'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a subject' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _messageController,
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
                      onPressed: _isSubmitting ? null : _submitForm,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('SEND MESSAGE'),
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
