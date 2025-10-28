import 'package:cloud_firestore/cloud_firestore.dart';

class SponsorModel {
  final String id;
  final String name;
  final String logoUrl;
  final String? websiteUrl;
  final int displayOrder;

  SponsorModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.websiteUrl,
    required this.displayOrder,
  });

  factory SponsorModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return SponsorModel(
      id: doc.id,
      name: data['name'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
      websiteUrl: data['websiteUrl'],
      displayOrder: data['displayOrder'] ?? 0,
    );
  }
}
