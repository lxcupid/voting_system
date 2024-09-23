import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';

class VotingsystemHome extends StatefulWidget {
  const VotingsystemHome({super.key});

  @override
  _VotingsystemHomeState createState() => _VotingsystemHomeState();
}

class _VotingsystemHomeState extends State<VotingsystemHome> {
  List<Candidate> filteredCandidates = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredCandidates = candidates; // Initialize with all candidates
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
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterCandidates,
            ),
          ),
          // Candidate Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350, mainAxisExtent: 450),
              itemCount: filteredCandidates.length,
              itemBuilder: (context, index) {
                return CandidateWidget(
                  candidate: filteredCandidates[index], // Use CandidateWidget
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
