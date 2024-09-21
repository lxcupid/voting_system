import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';

class VotingsystemHome extends StatelessWidget {
  const VotingsystemHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of candidates
    final List<Candidate> candidates = [
      Candidate(
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
        name: 'John Doe',
        motto: 'For a better future',
      ),
      Candidate(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
        name: 'Jane Smith',
        motto: 'Together we can!',
      ),
      Candidate(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
        name: 'Jane Smith',
        motto: 'Together we can!',
      ),
      Candidate(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
        name: 'Jane Smith',
        motto: 'Together we can!',
      ),
      Candidate(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
        name: 'Jane Smith',
        motto: 'Together we can!',
      ),
      Candidate(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
        name: 'Alice Johnson',
        motto: 'Your voice matters',
      ),
      // Add more candidates as needed
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 350,
            mainAxisExtent: 300 // Maximum width of each item
            ),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          return CandidateWidget(
            candidate: candidates[index], // Use CandidateWidget
          );
        },
      ),
    );
  }
}
