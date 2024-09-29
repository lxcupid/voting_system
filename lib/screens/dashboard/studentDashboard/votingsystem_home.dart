import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import Shared Preferences
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VotingsystemHome extends StatefulWidget {
  const VotingsystemHome({super.key});

  @override
  _VotingsystemHomeState createState() => _VotingsystemHomeState();
}

class _VotingsystemHomeState extends State<VotingsystemHome> {
  List<Candidate> candidates = []; // Store all candidates fetched from the API
  List<Candidate> filteredCandidates =
      []; // Store filtered candidates based on search
  String searchQuery = '';

  Future<void> fetchCandidates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? college = prefs.getString('college');

    if (college != null) {
      // Fetch candidates based on college
      final response = await http.get(
        Uri.parse(
            'http://localhost:8005/user/candidates/colleges?college=$college'), // Use the college ID
      );

      print('RESPONSE' + response.body);
      print(candidates);

      if (response.statusCode == 200) {
        final List<dynamic> candidatesJson = json.decode(response.body);
        setState(() {
          candidates = candidatesJson
              .map((json) => Candidate.fromJson(json))
              .toList(); // Convert JSON to Candidate objects
          filteredCandidates =
              candidates; // Initially, all candidates are shown
        });
      } else {
        throw Exception('Failed to load candidates: ${response.statusCode}');
      }
    } else {
      throw Exception('No college found in preferences');
    }
  }

  void _filterCandidates(String query) {
    setState(() {
      searchQuery = query;
      filteredCandidates = candidates
          .where((candidate) =>
              candidate.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredCandidates = candidates;
    fetchCandidates(); // Fetch candidates when the screen loads
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
              onChanged: _filterCandidates, // Call the filtering method
            ),
          ),
          // List of Candidates
          Expanded(
            child: candidates.isEmpty
                ? const Center(child: Text('NO CANDIDATES'))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      mainAxisExtent: 450,
                    ),
                    itemCount: filteredCandidates.length,
                    itemBuilder: (context, index) {
                      return CandidateWidget(
                        showMotto: true,
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
