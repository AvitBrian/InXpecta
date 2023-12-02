//TODO: Make model for this

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsModel {
  final String? uid;
  final String? id;
  final String? sourceName;
  final String? details;
  final DateTime? time;
  const ReportsModel(
      {required this.uid,
      required this.sourceName,
      required this.id,
      required this.details,
      required this.time});

  toJson() {
    return {
      "id": id,
      "sourceName": sourceName,
      "details": details,
      "time": time,
      "uid": uid
    };
  }

  factory ReportsModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return ReportsModel(
      uid: data?["uid"],
      id: document.id,
      sourceName: data?["sourceName"],
      details: data?["sourceDetails"],
      time: (data?["time"] as Timestamp).toDate(),
    );
  }
}
