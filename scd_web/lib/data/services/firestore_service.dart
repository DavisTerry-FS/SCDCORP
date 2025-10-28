import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scd_web/data/models/app_content_model.dart';
import 'package:scd_web/data/models/event_model.dart';
import 'package:scd_web/data/models/gallery_item_model.dart';
import 'package:scd_web/data/models/staff_member_model.dart';
import 'package:scd_web/data/models/pillar_model.dart';
import 'package:scd_web/data/models/sponsor_model.dart';

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
      developer.log(
        "Error fetching app content",
        error: e,
        name: 'FirestoreService',
      );
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
      developer.log(
        "Error fetching staff members",
        error: e,
        name: 'FirestoreService',
      );
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
      developer.log(
        "Error fetching events",
        error: e,
        name: 'FirestoreService',
      );
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
      developer.log(
        "Error fetching gallery items",
        error: e,
        name: 'FirestoreService',
      );
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
      developer.log(
        "Error fetching pillars",
        error: e,
        name: 'FirestoreService',
      );
      rethrow;
    }
  }

  /// Fetches all sponsors, ordered by their displayOrder.
  Future<List<SponsorModel>> getSponsors() async {
    try {
      final snapshot = await _db
          .collection('sponsors')
          .orderBy('displayOrder')
          .get();
      return snapshot.docs
          .map((doc) => SponsorModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      developer.log(
        "Error fetching sponsors",
        error: e,
        name: 'FirestoreService',
      );
      rethrow;
    }
  }

  /// Submits a contact form to Firestore.
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      await _db.collection('contact_submissions').add({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'unread', // For admin dashboard to track
      });
    } catch (e) {
      developer.log(
        "Error submitting contact form",
        error: e,
        name: 'FirestoreService',
      );
      rethrow;
    }
  }
}
