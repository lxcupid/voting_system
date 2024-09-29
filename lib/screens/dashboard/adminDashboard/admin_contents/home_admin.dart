import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_model.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_widgets.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  List<AdminCandidate> filteredCandidates = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredCandidates = adminCandidates;
  }

  void _filterCandidates(String query) {
    setState(() {
      searchQuery = query;
      filteredCandidates = adminCandidates
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
          // Candidate Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 400,
              ),
              itemCount: filteredCandidates.length,
              itemBuilder: (context, index) {
                return CandidateWidget(
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
