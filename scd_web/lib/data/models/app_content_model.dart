import 'package:cloud_firestore/cloud_firestore.dart';

class AppContentModel {
  final String missionStatement;
  final String visionStatement;
  final String history;
  final String joinUsTitle;
  final String joinUsText;

  AppContentModel({
    required this.missionStatement,
    required this.visionStatement,
    required this.history,
    required this.joinUsTitle,
    required this.joinUsText,
  });

  factory AppContentModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return AppContentModel(
      missionStatement: data['missionStatement'] ?? '',
      visionStatement: data['visionStatement'] ?? '',
      history: data['history'] ?? '',
      joinUsTitle: data['joinUsTitle'] ?? 'Become a Part of the Rhythm',
      joinUsText: data['joinUsText'] ?? '',
    );
  }
}
