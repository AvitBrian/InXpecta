import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/models/pie_data_model.dart';

class Pie extends StatelessWidget {
  final List<Map<String, dynamic>> yourKeyValueList;

  const Pie({super.key, required this.yourKeyValueList});

  @override
  Widget build(BuildContext context) {
    // Create PieChartModel
    final PieChartModel pieChartModel =
        PieChartModel.fromKeyValueList(yourKeyValueList);

    // Access PieChartSectionData instances
    final List<PieChartSectionData> pieChartSectionData =
        pieChartModel.pieChartSectionData;

    return PieChart(
      PieChartData(
        sectionsSpace: .5,
        sections: pieChartSectionData,
        // Add other properties as needed
      ),
    );
  }
}
