//TODO: Make model for this

import 'package:cloud_firestore/cloud_firestore.dart';

class SourceModel {
  final String? id;
  final String? sourceName;
  final double? notoriety;
  final String? status;
  const SourceModel(
      {required this.sourceName,
      required this.id,
      required this.notoriety,
      required this.status});

  toJson() {
    return {
      "id": id,
      "source_name": sourceName,
      "source_notoriety": notoriety,
      "status": status
    };
  }

  factory SourceModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return SourceModel(
      id: document.id,
      sourceName: data?["source_name"],
      notoriety: (data?["source_notoriety"] as num?)?.toDouble(),
      status: data?["status"],
    );
  }
}
