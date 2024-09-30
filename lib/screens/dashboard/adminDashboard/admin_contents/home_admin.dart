import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_model.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_widgets.dart';
import 'dart:io';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  List<AdminCandidate1> allCandidates = []; // List to hold all candidates
  List<AdminCandidate1> filteredCandidates = []; // List for filtered candidates
  String searchQuery = '';
  bool isLoading = true; // To manage loading state
  String apiUrl =
      'http://localhost:8005/user/candidates/votes'; // Update with your API endpoint

  @override
  void initState() {
    super.initState();
    _fetchCandidates();
  }

  Future<void> _fetchCandidates() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          allCandidates = jsonData
              .map((json) => AdminCandidate1.fromJson(json))
              .toList(); // Store all candidates
          filteredCandidates = List.from(
              allCandidates); // Initialize filteredCandidates with all candidates
          isLoading = false; // Set loading to false after fetching
        });
      } else {
        throw Exception('Failed to load candidates');
      }
    } catch (e) {
      print(e); // Handle errors
      setState(() {
        isLoading = false; // Set loading to false on error
      });
    }
  }

  void _filterCandidates(String query) {
    setState(() {
      searchQuery = query;
      // Filter based on the original list of candidates
      filteredCandidates = allCandidates
          .where((candidate) =>
              candidate.fullname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _exportToExcel() async {
    try {
      // Create an Excel document
      var excel = Excel.createExcel();

      // Group candidates by college
      Map<String, List<AdminCandidate1>> collegeGroups = {};
      for (var candidate in filteredCandidates) {
        collegeGroups.putIfAbsent(candidate.college, () => []).add(candidate);
      }

      // Create a sheet for each college
      collegeGroups.forEach((college, candidates) {
        // Create a new sheet for the college
        Sheet sheet = excel[college];

        // Add headers to the sheet
        sheet.appendRow([
          TextCellValue("Name"),
          TextCellValue("Position"),
          IntCellValue(0), // Placeholder for Total Votes
        ]);

        // Add candidate data to the sheet
        for (var candidate in candidates) {
          print('Adding candidate to $college: ${candidate.fullname}');
          sheet.appendRow([
            TextCellValue(candidate.fullname),
            TextCellValue(candidate.position),
            IntCellValue(candidate.totalVotes),
          ]);
        }
      });

      // Use the FilePicker to select the save location
      String? filePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Excel File',
        fileName: 'candidates.xlsx',
      );

      if (filePath != null) {
        // Save the file
        var file = File(filePath);
        final excelBytes = await excel.encode();

        if (excelBytes != null) {
          await file.writeAsBytes(excelBytes);
          print('File saved at: $filePath');
          // Show a message indicating the file has been exported
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Candidates exported to Excel!')),
          );
        } else {
          print('Failed to encode Excel data.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to encode Excel data.')),
          );
        }
      } else {
        print('User canceled the file picker.');
      }
    } catch (e) {
      print('Error occurred while exporting to Excel: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search candidates...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: _filterCandidates,
                  ),
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.green),
                  onPressed: _exportToExcel,
                  tooltip: 'Export to Excel',
                ),
              ],
            ),
          ),
          // Loading Indicator
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (filteredCandidates.isEmpty)
            const Center(child: Text('No candidates found.'))
          else
            // Candidate Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 400,
                ),
                itemCount: filteredCandidates.length,
                itemBuilder: (context, index) {
                  return AdminCandidateWidget(
                    candidate: filteredCandidates[index],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
