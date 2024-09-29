import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/piegraph_page.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/vs_container.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PieChartModel> data = [
      PieChartModel(college: 'CTED', votes: 48, color: Colors.red),
      PieChartModel(college: 'CCST', votes: 97, color: Colors.orange),
      PieChartModel(college: 'CTHM', votes: 91, color: Colors.yellow),
      PieChartModel(college: 'CHK', votes: 67, color: Colors.green),
      PieChartModel(college: 'CAS', votes: 76, color: Colors.indigo),
      PieChartModel(college: 'COA', votes: 39, color: Colors.blue),
      PieChartModel(college: 'COE', votes: 83, color: Colors.purple),
      PieChartModel(college: 'COB', votes: 54, color: Colors.teal),
    ];

    // Extracting data for the bar chart
    List<double> voteCounts =
        data.map((item) => item.votes.toDouble()).toList();
    List<String> collegeNames = data.map((item) => item.college).toList();
    List<Color> barColors = data.map((item) => item.color).toList();

    int totalVotes = data.fold(0, (sum, item) => sum + item.votes);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  vsContainer(
                    label: 'Vote Counts Bar Graph',
                    child: CollegeBarChart(
                      colors: barColors,
                      values: voteCounts,
                      titles: collegeNames,
                    ),
                  ),
                  vsContainer(
                      label: 'Vote Counts of every College by percentage',
                      child: CollegePieChart()),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  vsContainer(
                    label: 'Total Vote Counts',
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            totalVotes.toString(),
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CollegeBarChart extends StatelessWidget {
  final List<double> values; // List of values for the bars
  final List<String> titles; // List of titles for each bar
  final List<Color> colors; // List of colors for each bar

  CollegeBarChart({
    required this.values,
    required this.titles,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(values.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: values[index],
                color: colors[index], // Assign color from the list
                width: 16,
                borderRadius: BorderRadius.zero, // Remove rounding on bars
              ),
            ],
          );
        }),
        gridData: FlGridData(show: false), // Disable grid lines
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: false)), // Disable left axis labels
          rightTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: false)), // Disable right axis labels
          topTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: false)), // Disable top axis labels
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                int index = value.toInt();
                if (index >= 0 && index < titles.length) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        color: colors[index], // Color box
                        margin: EdgeInsets.only(
                            right: 4), // Space between box and text
                      ),
                      Text(
                        titles[index],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }
                return SizedBox(); // Return empty box if index is out of range
              },
              reservedSize: 28, // Reserve space for titles
            ),
          ),
        ),
        borderData: FlBorderData(show: false), // Optional: remove border
      ),
    );
  }
}
