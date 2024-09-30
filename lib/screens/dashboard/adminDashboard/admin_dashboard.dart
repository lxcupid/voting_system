import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  // List to hold bar chart data
  List<BarChartGroupData> barChartData = [];
  List<String> collegeNames = []; // List to hold college names
  int totalVotes = 0; // Variable to hold total votes

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchTotalVotes();
  }

  // Method to fetch data from the API
  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8005/user/votes/colleges'));

      if (response.statusCode == 200) {
        // Parse the response body
        var data = json.decode(response.body);

        // Clear previous data
        barChartData.clear();
        collegeNames.clear();

        // List of colors to use for each bar
        List<Color> barColors = [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.orange,
          Colors.purple,
          Colors.cyan,
          Colors.amber,
        ];

        // Assuming data is an array of objects
        for (int i = 0; i < data.length; i++) {
          // Add college name to the list
          collegeNames.add(data[i]['college_id']);

          // Determine the color to use for the current bar
          Color barColor =
              barColors[i % barColors.length]; // Cycle through colors

          // Add bar chart data
          barChartData.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i]['total_votes'].toDouble(),
                  color: barColor, // Use the determined color
                  borderRadius: BorderRadius.zero,
                  width: 20,
                ),
              ],
            ),
          );
        }

        setState(() {
          // Update the state with the fetched data
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle errors here, such as showing an error message
      print(e);
    }
  }

  Future<void> fetchTotalVotes() async {
    final String url =
        'http://localhost:8005/user/votes'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          totalVotes = data['total_votes']; // Update the total votes
        });
      } else {
        // Handle the error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  // Method to get titles for the bottom axis
  String getBottomTitle(double value) {
    int index = value.toInt();
    if (index >= 0 && index < collegeNames.length) {
      return collegeNames[index]; // Return college name from the list
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'OVERALL VOTES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Border radius
                border: Border.all(
                  color: Colors.green, // Border color
                  width: 2, // Border width
                ),
              ),
              child: Center(
                child: Text(
                  '$totalVotes', // Display total votes
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'OVERALL VOTES PER COLLEGE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Border radius
                border: Border.all(
                  color: Colors.green, // Border color
                  width: 2, // Border width
                ),
              ),
              height: 300,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  barGroups: barChartData,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true, // Show bottom titles
                        getTitlesWidget: (value, meta) {
                          return Text(
                            getBottomTitle(value),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, // Show left titles
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, // Hide top titles
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, // Hide right titles
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
