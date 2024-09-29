import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartModel {
  final String college;
  final int votes;
  final Color color;

  PieChartModel({
    required this.college,
    required this.votes,
    required this.color,
  });
}

class CollegePieChart extends StatelessWidget {
  CollegePieChart({super.key});

  final List<PieChartModel> data = [
    PieChartModel(
      college: 'CTED',
      votes: 48,
      color: Colors.red,
    ),
    PieChartModel(
      college: 'CCST',
      votes: 97,
      color: Colors.orange,
    ),
    PieChartModel(
      college: 'CTHM',
      votes: 91,
      color: Colors.yellow,
    ),
    PieChartModel(
      college: 'CHK',
      votes: 67,
      color: Colors.green,
    ),
    PieChartModel(
      college: 'CAS',
      votes: 76,
      color: Colors.indigo,
    ),
    PieChartModel(
      college: 'COA',
      votes: 39,
      color: Colors.blue,
    ),
    PieChartModel(
      college: 'COE',
      votes: 83,
      color: Colors.purple,
    ),
    PieChartModel(
      college: 'COB',
      votes: 54,
      color: Colors.teal,
    ),
  ];

  int get totalVotes {
    return data.fold(0, (sum, item) => sum + item.votes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: PieChart(
            PieChartData(
              sections: data.map((PieChartModel model) {
                final percentage = (model.votes / totalVotes) * 100;
                return PieChartSectionData(
                  color: model.color,
                  value: model.votes.toDouble(),
                  radius: 70,
                  title: '${percentage.toStringAsFixed(1)}%',
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
              sectionsSpace: 2,
              centerSpaceRadius: 50,
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 5,
          children: data.map((PieChartModel model) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  color: model.color,
                ),
                const SizedBox(width: 5),
                Text(
                  model.college,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
