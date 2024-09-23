import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';

class CandidateDropdown extends StatelessWidget {
  final Candidate? selectedCandidate; // this hold the Candidate object
  final String positionLabel;
  final List<Candidate> candidates; // Change to list of Candidate objects
  final ValueChanged<Candidate?> onChanged;

  const CandidateDropdown({
    super.key,
    required this.selectedCandidate,
    required this.candidates,
    required this.onChanged,
    this.positionLabel = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 140,
          child: Text(
            positionLabel,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 500,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Candidate?>(
              value: selectedCandidate,
              hint: const Text('Select Candidate'),
              isExpanded: false,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              items: candidates.map((candidate) {
                return DropdownMenuItem<Candidate?>(
                  value: candidate, // Use the Candidate object as value
                  child: Text(candidate.name),
                );
              }).toList(),
              onChanged: (Candidate? newCandidate) {
                onChanged(
                    newCandidate); // Pass the Candidate object to onChanged
              },
            ),
          ),
        ),
      ],
    );
  }
}
