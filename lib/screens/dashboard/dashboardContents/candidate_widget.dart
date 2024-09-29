import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';

class CandidateWidget extends StatelessWidget {
  final Candidate candidate;
  final double? imageHeight;
  final double? imageWidth;
  final MainAxisAlignment alignment;
  final bool showMotto;

  const CandidateWidget({
    super.key,
    required this.candidate,
    this.showMotto = true,
    this.alignment = MainAxisAlignment.start,
    this.imageHeight = 200,
    this.imageWidth = 150,
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
              height: imageHeight,
              width: imageWidth,
              child: candidate.image
                      .isNotEmpty // Check if the image string is not empty
                  ? Center(
                      child: Image.network(
                        candidate.image, // Use the URL for the image
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Text('Image failed to load'));
                        },
                      ),
                    )
                  : const Center(child: Text('No image available')),
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
