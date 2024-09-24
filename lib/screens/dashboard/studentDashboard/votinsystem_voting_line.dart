import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/core/providers/selected_candidate_provider.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_dropdown.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidates_dialog_box.dart';

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

  String getCandidateNameById(int? candidateId) {
    if (candidateId == null || candidateId == -1) {
      return 'None'; // Return 'None' if the candidateId is empty or invalid
    }

    final candidate = candidates.firstWhere(
      (candidate) => candidate.candidateId == candidateId,
      orElse: () => Candidate(
        candidateId: -1,
        name: 'None', imageUrl: 'none', position: 'none',
        motto: 'none', // Handle non-existent candidate by returning 'None'
      ),
    );

    return candidate.name;
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
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        final selectedCandidates =
                            Provider.of<SelectedCandidateProvider>(context,
                                    listen: false)
                                .elected;

                        // Retrieve candidate names based on selected IDs
                        final presidentName = getCandidateNameById(
                            selectedCandidates.presidentId);
                        final vicePresidentName = getCandidateNameById(
                            selectedCandidates.vicePresidentId);
                        final secretaryName = getCandidateNameById(
                            selectedCandidates.secretaryId);

                        // Show the custom dialog regardless of the selected candidates
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CandidatesDialogBox(
                              presidentName: presidentName,
                              vicePresidentName: vicePresidentName,
                              secretaryName: secretaryName,
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
