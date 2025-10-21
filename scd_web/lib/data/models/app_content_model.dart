import 'package:cloud_firestore/cloud_firestore.dart';

class AppContentModel {
  final String missionStatement;
  final String visionStatement;
  final String history;

  AppContentModel({
    required this.missionStatement,
    required this.visionStatement,
    required this.history,
  });

  factory AppContentModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return AppContentModel(
      missionStatement: data['missionStatement'] ?? '',
      visionStatement: data['visionStatement'] ?? '',
      history: data['history'] ?? '',
    );
  }
}
