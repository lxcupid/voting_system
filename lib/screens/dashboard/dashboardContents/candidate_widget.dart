import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';

class CandidateWidget extends StatefulWidget {
  final Candidate candidate;

  const CandidateWidget({super.key, required this.candidate});

  @override
  State<CandidateWidget> createState() => _CandidateWidgetState();
}

class _CandidateWidgetState extends State<CandidateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 150,
              child: Image.network(
                widget.candidate.imageUrl,
                fit: BoxFit.cover, // Ensures the image covers the space
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image failed to load'));
                },
              ),
            ),
            const SizedBox(height: 8), // Spacing
            Text(
              widget.candidate.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4), // Spacing
            Text(
              widget.candidate.motto,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
