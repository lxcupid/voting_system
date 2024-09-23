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
  Candidate? selectedPresident; // Separate variable for President
  Candidate? selectedVicePresident;
  Candidate? selectedSecretary; // Separate variable for Vice President
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
                          selectedPresident =
                              newCandidate; // Update the selected President
                          selectedId = newCandidate?.candidateId;
                          print("Selected President ID: $selectedId");
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setPresidentID(selectedId ?? -1);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CandidateDropdown(
                      positionLabel: 'Vice President: ',
                      selectedCandidate:
                          selectedVicePresident, // Use separate variable
                      candidates: vpresidentCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedVicePresident =
                              newCandidate; // Update the selected Vice President
                          selectedId = newCandidate?.candidateId;
                          print("Selected Vice President ID: $selectedId");
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setVicepresidentID(selectedId ?? -1);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CandidateDropdown(
                      positionLabel: 'Secretary: ',
                      selectedCandidate:
                          selectedSecretary, // Use separate variable
                      candidates: secretaryCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedSecretary =
                              newCandidate; // Update the selected Vice President
                          selectedId = newCandidate?.candidateId;
                          print("Selected Secretary ID: $selectedId");
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setSecretaryID(selectedId ?? -1);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // Access the provider to get the current selected candidate model
                        final selectedCandidates =
                            Provider.of<SelectedCandidateProvider>(context,
                                    listen: false)
                                .elected;

                        // Print the current selected candidate model
                        print("Selected Candidates:");
                        print(
                            "President ID: ${selectedCandidates.presidentId}");
                        print(
                            "Vice President ID: ${selectedCandidates.vicePresidentId}");
                        print(
                            "Secretary ID: ${selectedCandidates.secretaryId}");
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
