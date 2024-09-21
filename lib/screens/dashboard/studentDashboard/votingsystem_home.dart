import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';

class VotingsystemHome extends StatefulWidget {
  const VotingsystemHome({super.key});

  @override
  _VotingsystemHomeState createState() => _VotingsystemHomeState();
}

class _VotingsystemHomeState extends State<VotingsystemHome> {
  List<Candidate> candidates = [
    Candidate(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
      name: 'John Doe',
      motto:
          'Empowering Change for a Brighter Tomorrow: Together, we can build a future where every voice is heard and every dream is realizede',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
      name: 'Jane Smith',
      motto:
          'Together We Rise, Together We Thrive: By uniting our strengths and embracing our differences, we can create a community where everyone has the opportunity to succeed',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
      name: 'Alice Johnson',
      motto:
          'Your Voice, Our Future: Join us in shaping a tomorrow that reflects our shared values and aspirations, where everyone plays a vital role in the journey ahead.',
    ),
    Candidate(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
      name: 'John Doe',
      motto:
          'Unity in Diversity, Strength in Community: Embracing our unique perspectives, we can foster an environment that promotes collaboration, understanding, and progress for all',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
      name: 'Jane Smith',
      motto:
          'Innovating for Progress and Prosperity: Together, we will develop innovative solutions that empower individuals and uplift communities, driving positive change for generations to come',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
      name: 'Alice Johnson',
      motto:
          'Innovating for Progress and Prosperity: Together, we will develop innovative solutions that empower individuals and uplift communities, driving positive change for generations to come',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
      name: 'Jane Smith',
      motto:
          'Innovating for Progress and Prosperity: Together, we will develop innovative solutions that empower individuals and uplift communities, driving positive change for generations to come',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
      name: 'Alice Johnson',
      motto:
          'Innovating for Progress and Prosperity: Together, we will develop innovative solutions that empower individuals and uplift communities, driving positive change for generations to come',
    ),
    Candidate(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
      name: 'Alice Johnson',
      motto:
          'Your voice matters, Your voice matters, Your voice matters, Your voice matters, Your voice matters, Your voice matters, Your voice matters',
    ),
    // Add more candidates as needed
  ];

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
