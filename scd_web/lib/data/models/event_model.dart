import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final DateTime date;
  final String locationName;
  final String locationAddress;
  final String description;
  final String imageUrl;
  final String type;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.locationName,
    required this.locationAddress,
    required this.description,
    required this.imageUrl,
    required this.type,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      locationName: data['locationName'] ?? '',
      locationAddress: data['locationAddress'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      type: data['type'] ?? 'Performance',
    );
  }
}
