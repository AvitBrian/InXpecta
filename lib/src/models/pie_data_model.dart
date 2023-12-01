import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartModel {
  final List<PieChartSectionDataModel> sections;

  PieChartModel({required this.sections});

  factory PieChartModel.fromKeyValueList(
      List<Map<String, dynamic>> keyValueList) {
    List<PieChartSectionDataModel> sections = keyValueList
        .map((item) => PieChartSectionDataModel.fromJson(item))
        .toList();

    return PieChartModel(sections: sections);
  }

  List<PieChartSectionData> get pieChartSectionData {
    return sections.map((section) => section.toPieChartSectionData()).toList();
  }
}

class PieChartSectionDataModel {
  final double? value;
  final Color? color;
  final String? title;
  final double? radius;
  final bool? showTitle;

  PieChartSectionDataModel(
      {required this.value,
      required this.color,
      required this.title,
      required this.radius,
      required this.showTitle});

  factory PieChartSectionDataModel.fromJson(Map<String, dynamic> json) {
    return PieChartSectionDataModel(
        value: json['source_notoriety'] ?? 0.0,
        color: Color(json['color'] ?? 0xFFF7e5d01),
        title: json['source_name'] ?? '',
        radius: 60,
        showTitle: false);
  }

  PieChartSectionData toPieChartSectionData() {
    return PieChartSectionData(
        value: value,
        color: color!.withAlpha(value!.toInt() * 3),
        title: title,
        radius: radius,
        showTitle: showTitle
        // Add other properties as needed
        );
  }
}
