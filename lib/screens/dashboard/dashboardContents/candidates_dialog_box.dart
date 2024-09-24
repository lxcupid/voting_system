import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/core/providers/selected_candidate_provider.dart';

class CandidatesDialogBox extends StatefulWidget {
  final String presidentName;
  final String vicePresidentName;
  final String secretaryName;
  final String treasurerName;
  final String dataprivacyName;
  final String itrepresentativeName;
  final String isrepresentativeName;
  final VoidCallback onVotePressed;
  final VoidCallback oncancelPressed;

  const CandidatesDialogBox({
    super.key,
    required this.presidentName,
    required this.vicePresidentName,
    required this.secretaryName,
    required this.treasurerName,
    required this.dataprivacyName,
    required this.itrepresentativeName,
    required this.isrepresentativeName,
    required this.onVotePressed,
    required this.oncancelPressed,
  });

  @override
  State<CandidatesDialogBox> createState() => _CandidatesDialogBoxState();
}

class _CandidatesDialogBoxState extends State<CandidatesDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black, // Add a border if needed
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, // Shadow color
              blurRadius: 10, // Shadow blur
              offset: Offset(0, 5), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Selected Candidates",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildCandidateRow("President", widget.presidentName),
            const SizedBox(height: 10),
            _buildCandidateRow("Vice President", widget.vicePresidentName),
            const SizedBox(height: 10),
            _buildCandidateRow("Secretary", widget.secretaryName),
            const SizedBox(height: 10),
            _buildCandidateRow("Treasurer", widget.treasurerName),
            const SizedBox(height: 10),
            _buildCandidateRow("Data Privacy", widget.dataprivacyName),
            const SizedBox(height: 10),
            _buildCandidateRow(
                "IT Representative", widget.itrepresentativeName),
            const SizedBox(height: 10),
            _buildCandidateRow(
                "IS Representative", widget.isrepresentativeName),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: MaterialButton(
                    onPressed: widget.oncancelPressed,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: MaterialButton(
                    onPressed: widget.onVotePressed,
                    child: const Text(
                      "Vote",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateRow(String position, String name) {
    return Text(
      "$position: $name",
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
