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
  Candidate? selectedTreasurer;
  Candidate? selectedDataPrivacy;
  Candidate? selectedITRepresentative;
  Candidate? selectedISRepresentative;
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
    final treasurerCandidates = getCandidatesByPosition('Treasurer');
    final dataprivacyrCandidates = getCandidatesByPosition('Data Privacy');
    final itrepresentativeCandidates =
        getCandidatesByPosition('IT Representative');
    final isrepresentativeCandidates =
        getCandidatesByPosition('IS Representative');

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
                    CandidateDropdown(
                      positionLabel: 'Treasurer: ',
                      selectedCandidate: selectedTreasurer,
                      candidates: treasurerCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedTreasurer = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setTreasurerID(selectedId ?? -1);
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CandidateDropdown(
                      positionLabel: 'Data Privacy: ',
                      selectedCandidate: selectedDataPrivacy,
                      candidates: dataprivacyrCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedDataPrivacy = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setDataprivacyID(selectedId ?? -1);
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CandidateDropdown(
                      positionLabel: 'IT Represantative: ',
                      selectedCandidate: selectedITRepresentative,
                      candidates: itrepresentativeCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedITRepresentative = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setITRepresentativeID(selectedId ?? -1);
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CandidateDropdown(
                      positionLabel: 'IS Representative: ',
                      selectedCandidate: selectedISRepresentative,
                      candidates: isrepresentativeCandidates,
                      onChanged: (Candidate? newCandidate) {
                        setState(() {
                          selectedISRepresentative = newCandidate;
                          selectedId = newCandidate?.candidateId;
                          Provider.of<SelectedCandidateProvider>(context,
                                  listen: false)
                              .setISRepresentativeID(selectedId ?? -1);
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: MaterialButton(
                        onPressed: () async {
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
                          final treasurerName = getCandidateNameById(
                              selectedCandidates.treasurerId);
                          final dataprivacyName = getCandidateNameById(
                              selectedCandidates.dataprivacyId);
                          final itrepresentativeName = getCandidateNameById(
                              selectedCandidates.itrepresentativeId);
                          final isrepresentativeName = getCandidateNameById(
                              selectedCandidates.isrepresentativeId);

                          // Show the custom dialog regardless of the selected candidates
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CandidatesDialogBox(
                                presidentName: presidentName,
                                vicePresidentName: vicePresidentName,
                                secretaryName: secretaryName,
                                treasurerName: treasurerName,
                                dataprivacyName: dataprivacyName,
                                itrepresentativeName: itrepresentativeName,
                                isrepresentativeName: isrepresentativeName,
                                onVotePressed: () {
                                  Provider.of<SelectedCandidateProvider>(
                                          context,
                                          listen: false)
                                      .resetSelections();

                                  // Reset selected candidates in the state
                                  setState(() {
                                    selectedPresident = null;
                                    selectedVicePresident = null;
                                    selectedSecretary = null;
                                    selectedTreasurer = null;
                                    selectedDataPrivacy = null;
                                    selectedITRepresentative = null;
                                    selectedISRepresentative = null;
                                    selectedId = null; // Reset selected ID
                                  });

                                  // Show success message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Vote successfully added!'),
                                      duration: Duration(seconds: 4),
                                    ),
                                  );

                                  Navigator.of(context).pop();
                                },
                                oncancelPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Verify",
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
              ),
            ),
            SizedBox(
              width: 400,
              child: selectedId != null
                  ? CandidateWidget(
                      imageHeight: 300,
                      imageWidth: 250,
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
