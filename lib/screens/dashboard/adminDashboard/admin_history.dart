import 'package:flutter/material.dart';
import 'package:voting_system/widgets/login_dropdown.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminHistory extends StatefulWidget {
  const AdminHistory({super.key});

  @override
  State<AdminHistory> createState() => _AdminHistoryState();
}

class _AdminHistoryState extends State<AdminHistory> {
  String? selectedValue; // College
  List<ElectionModel> colleges = []; // List to hold college data
  List<CandidateModel> candidates = []; // List to hold candidate data

  @override
  void initState() {
    super.initState();
    fetchColleges(); // Fetch colleges when the widget is initialized
  }

  // Function to fetch colleges from the API
  Future<void> fetchColleges() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:8005/user/elections')); // Replace with your API endpoint
      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(response.body); // Decode the JSON response
        final List<dynamic> electionIds =
            data['election_ids']; // Access the election_ids

        setState(() {
          colleges = electionIds
              .map((id) => ElectionModel.fromJson(id))
              .toList(); // Create ElectionModel objects
        });
      } else {
        throw Exception('Failed to load colleges');
      }
    } catch (e) {
      print('Error fetching colleges: $e');
    }
  }

  // Function to fetch candidates based on the selected election ID
  Future<void> fetchCandidates(String electionID) async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:8005/user/elections/history?electionID=$electionID')); // Replace with your API endpoint
      if (response.statusCode == 200) {
        final List<dynamic> candidateData =
            json.decode(response.body); // Decode the JSON response

        setState(() {
          candidates = candidateData
              .map((candidate) => CandidateModel.fromJson(candidate))
              .toList(); // Create CandidateModel objects
        });
      } else {
        throw Exception('Failed to load candidates');
      }
    } catch (e) {
      print('Error fetching candidates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16), // Add padding if needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Dropdown positioned at the top right
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 400,
              child: CustomDropdown(
                backgroundColor: Colors.grey[100],
                options: colleges.map((college) => college.electionId).toList(),
                selectedValue: selectedValue,
                hintText: 'Select Elections',
                borderRadius: 12.0,
                textStyle: const TextStyle(fontSize: 16),
                onChanged: (value) {
                  setState(() {
                    selectedValue = colleges
                        .firstWhere((college) => college.electionId == value)
                        .electionId;
                    fetchCandidates(
                        selectedValue!); // Fetch candidates when a college is selected
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Candidates:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          // Display candidates if available
          if (candidates.isNotEmpty) ...[
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return CandidateCard(
                    fullname: candidate.fullname,
                    position: candidate.position,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Define the CandidateModel to hold candidate data
class CandidateModel {
  final String position;
  final String fullname;

  CandidateModel({required this.position, required this.fullname});

  // Factory constructor to create a CandidateModel object from JSON
  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      position: json['position'],
      fullname: json['fullname'],
    );
  }
}

// Updated ElectionModel to properly construct from JSON
class ElectionModel {
  final String electionId;

  ElectionModel({required this.electionId});

  // Factory constructor to create an ElectionModel object from JSON
  factory ElectionModel.fromJson(String electionId) {
    return ElectionModel(electionId: electionId);
  }
}

class CandidateCard extends StatelessWidget {
  final String fullname;
  final String position;

  const CandidateCard({
    Key? key,
    required this.fullname,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Set border radius to zero
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$position: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              fullname,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
