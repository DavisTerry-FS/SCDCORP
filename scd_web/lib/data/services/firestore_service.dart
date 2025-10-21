import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scd_web/data/models/app_content_model.dart';
import 'package:scd_web/data/models/event_model.dart';
import 'package:scd_web/data/models/gallery_item_model.dart';
import 'package:scd_web/data/models/staff_member_model.dart';
import 'package:scd_web/data/models/pillar_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Private constructor for the singleton
  FirestoreService._();
  // The single, static instance of the service
  static final FirestoreService instance = FirestoreService._();

  /// Fetches the main content document for the app (mission, vision, etc.).
  Future<AppContentModel> getAppContent() async {
    try {
      final doc = await _db.collection('app_content').doc('main').get();
      if (doc.exists) {
        return AppContentModel.fromFirestore(doc);
      } else {
        // This provides a clear error if the 'main' document is missing.
        throw Exception(
          "App content document ('main') not found in Firestore.",
        );
      }
    } catch (e) {
      print("Error fetching app content: $e");
      rethrow; // Rethrowing allows the UI to handle the error state.
    }
  }

  /// Fetches all staff members, ordered by their displayOrder.
  Future<List<StaffMemberModel>> getStaffMembers() async {
    try {
      final snapshot = await _db
          .collection('staff')
          .orderBy('displayOrder')
          .get();
      return snapshot.docs
          .map((doc) => StaffMemberModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error fetching staff members: $e");
      rethrow;
    }
  }

  /// Fetches all events, ordered by date descending.
  Future<List<EventModel>> getEvents() async {
    try {
      final snapshot = await _db
          .collection('events')
          .orderBy('date', descending: true)
          .get();
      return snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching events: $e");
      rethrow;
    }
  }

  /// Fetches all gallery items, ordered by timestamp descending.
  Future<List<GalleryItemModel>> getGalleryItems() async {
    try {
      final snapshot = await _db
          .collection('gallery_items')
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => GalleryItemModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error fetching gallery items: $e");
      rethrow;
    }
  }

  /// Fetches all pillars, ordered by their displayOrder.
  Future<List<PillarModel>> getPillars() async {
    try {
      final snapshot = await _db
          .collection('pillars')
          .orderBy('displayOrder')
          .get();
      return snapshot.docs
          .map((doc) => PillarModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error fetching pillars: $e");
      rethrow;
    }
  }
}
