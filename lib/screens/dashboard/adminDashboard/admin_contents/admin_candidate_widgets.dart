import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_model.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/home/admin_candidate_model.dart';

class AdminCandidateWidget extends StatelessWidget {
  final AdminCandidate1 candidate;
  final double? imageHeight;
  final double? imageWidth;
  final MainAxisAlignment alignment;
  final bool showMotto;

  const AdminCandidateWidget({
    super.key,
    required this.candidate,
    this.showMotto = true,
    this.alignment = MainAxisAlignment.start,
    this.imageHeight = 200,
    this.imageWidth = 150,
  });

  @override
  Widget build(BuildContext context) {
    // Decode the Base64 or Uint8List byte data
    Uint8List? imageBytes;
    if (candidate.image.isNotEmpty) {
      try {
        imageBytes =
            base64Decode(candidate.image); // Decoding if it's a Base64 string
      } catch (e) {
        imageBytes = null; // In case of decoding error
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Rounded corners
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
              child: imageBytes != null && imageBytes.isNotEmpty
                  ? Center(
                      child: Image.memory(
                        imageBytes,
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
              candidate.fullname,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
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
            const SizedBox(height: 8), // Additional spacing
            Text(
              '${candidate.totalVotes} votes',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
