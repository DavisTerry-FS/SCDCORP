import 'package:cloud_firestore/cloud_firestore.dart';

class PillarModel {
  final String id;
  final String title;
  final String description;
  final String image; // Asset path
  final int displayOrder;

  PillarModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.displayOrder,
  });

  factory PillarModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PillarModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      // Assuming 'image' field in Firestore stores the asset path e.g., 'assets/pillar1.png'
      image: data['image'] ?? '',
      displayOrder: data['displayOrder'] ?? 0,
    );
  }
}
