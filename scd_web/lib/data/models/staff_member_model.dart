import 'package:cloud_firestore/cloud_firestore.dart';

class StaffMemberModel {
  final String id;
  final String name;
  final String role;
  final String bio;
  final String photoUrl;
  final int displayOrder;

  StaffMemberModel({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.photoUrl,
    required this.displayOrder,
  });

  factory StaffMemberModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return StaffMemberModel(
      id: doc.id,
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      bio: data['bio'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      displayOrder: data['displayOrder'] ?? 0,
    );
  }
}
