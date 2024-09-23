import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/core/providers/selected_candidate_provider.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_dropdown.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';

class VotinsystemVotingLine extends StatefulWidget {
  const VotinsystemVotingLine({super.key});

  @override
  State<VotinsystemVotingLine> createState() => _VotingSystemVotingLineState();
}

class _VotingSystemVotingLineState extends State<VotinsystemVotingLine> {
  Candidate? selectedPresident;
  Candidate? selectedVicePresident;
  Candidate? selectedSecretary;
  int? selectedId;

  List<Candidate> getCandidatesByPosition(String position) {
    return candidates
        .where((candidate) => candidate.position == position)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final presidentCandidates = getCandidatesByPosition('President');
    final vpresidentCandidates = getCandidatesByPosition('Vice President');
    final secretaryCandidates = getCandidatesByPosition('Secretary');

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CandidateDropdown(
                      positionLabel: 'President: ',
                      selectedCandidate: selectedPresident,
                      candidates: presidentCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedPresident = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setPresidentID(selectedId ?? -1);
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    CandidateDropdown(
                      positionLabel: 'Vice President: ',
                      selectedCandidate: selectedVicePresident,
                      candidates: vpresidentCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedVicePresident = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setVicepresidentID(selectedId ?? -1);
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    CandidateDropdown(
                      positionLabel: 'Secretary: ',
                      selectedCandidate: selectedSecretary,
                      candidates: secretaryCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedSecretary = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setSecretaryID(selectedId ?? -1);
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        final selectedCandidates =
                            Provider.of<SelectedCandidateProvider>(context,
                                    listen: false)
                                .elected;

                        // Show a dialog box with the selected candidates
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Selected Candidates"),
                              content: Text(
                                "President ID: ${selectedCandidates.presidentId}\n"
                                "Vice President ID: ${selectedCandidates.vicePresidentId}\n"
                                "Secretary ID: ${selectedCandidates.secretaryId}",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Send"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 400,
              child: selectedId != null
                  ? CandidateWidget(
                      alignment: MainAxisAlignment.center,
                      candidate: candidates
                          .firstWhere((c) => c.candidateId == selectedId),
                      showMotto: true,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Image.asset('icons/plsp_logo1.png')),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
