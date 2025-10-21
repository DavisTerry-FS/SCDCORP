import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scd_web/data/models/staff_member_model.dart';

class StaffCard extends StatelessWidget {
  final StaffMemberModel staffMember;

  const StaffCard({super.key, required this.staffMember});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: CachedNetworkImageProvider(staffMember.photoUrl),
            ),
            const SizedBox(height: 16),
            Text(
              staffMember.name,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              staffMember.role,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
