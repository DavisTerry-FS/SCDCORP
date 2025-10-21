import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryItemModel {
  final String id;
  final String type; // "photo" or "video"
  final String url;
  final String? thumbnailUrl;
  final String caption;
  final String category;
  final Timestamp timestamp;

  GalleryItemModel({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    required this.caption,
    required this.category,
    required this.timestamp,
  });

  factory GalleryItemModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return GalleryItemModel(
      id: doc.id,
      type: data['type'] ?? 'photo',
      url: data['url'] ?? '',
      thumbnailUrl: data['thumbnailUrl'],
      caption: data['caption'] ?? '',
      category: data['category'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
