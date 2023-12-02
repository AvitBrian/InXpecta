import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/models/pie_data_model.dart';

class Indicators extends StatelessWidget {
  final List<Map<String, dynamic>> yourKeyValueList;
  const Indicators({super.key, required this.yourKeyValueList});

  @override
  Widget build(BuildContext context) {
    // Create PieChartModel
    final PieChartModel pieChartModel =
        PieChartModel.fromKeyValueList(yourKeyValueList);

    // Access PieChartSectionData instances
    final List<PieChartSectionData> pieChartSectionData =
        pieChartModel.pieChartSectionData;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.from(pieChartSectionData.map((e) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: e.color, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(e.title),
                  ),
                ),
              ),
              const SizedBox(width: 8)
            ],
          );
        })),
      ),
    );
  }
}
