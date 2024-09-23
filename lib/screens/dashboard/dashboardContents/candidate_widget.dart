import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';

class CandidateWidget extends StatelessWidget {
  final Candidate candidate;
  final MainAxisAlignment alignment; // Change to non-nullable with default
  final bool showMotto; // Parameter to control motto visibility

  const CandidateWidget({
    super.key,
    required this.candidate,
    this.showMotto = true,
    this.alignment =
        MainAxisAlignment.start, // Default to start if not specified
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: alignment,
          children: [
            SizedBox(
              height: 200,
              width: 150,
              child: Image.network(
                candidate.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image failed to load'));
                },
              ),
            ),
            const SizedBox(height: 8), // Spacing
            Text(
              candidate.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4), // Spacing

            // Conditionally show the motto
            if (showMotto)
              Text(
                candidate.motto,
                style:
                    const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
