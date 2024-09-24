import 'package:flutter/material.dart';

class CandidatesDialogBox extends StatefulWidget {
  final String presidentName;
  final String vicePresidentName;
  final String secretaryName;

  const CandidatesDialogBox({
    Key? key,
    required this.presidentName,
    required this.vicePresidentName,
    required this.secretaryName,
  }) : super(key: key);

  @override
  State<CandidatesDialogBox> createState() => _CandidatesDialogBoxState();
}

class _CandidatesDialogBoxState extends State<CandidatesDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.green, // Add a border if needed
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
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Vote"),
              ),
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
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
