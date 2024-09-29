import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:voting_system/core/providers/selected_candidate_provider.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_dropdown.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidate_widget.dart';
import 'package:voting_system/screens/dashboard/dashboardContents/candidates_dialog_box.dart';
import 'package:http/http.dart' as http;

class VotinsystemVotingLine extends StatefulWidget {
  const VotinsystemVotingLine({super.key});

  @override
  State<VotinsystemVotingLine> createState() => _VotingSystemVotingLineState();
}

class _VotingSystemVotingLineState extends State<VotinsystemVotingLine> {
  List<Candidate> candidates = [];
  Candidate? selectedPresident;
  Candidate? selectedVicePresident;
  Candidate? selectedSecretary;
  Candidate? selectedTreasurer;
  Candidate? selectedDataPrivacy;
  Candidate? selectedITRepresentative;
  Candidate? selectedISRepresentative;
  int? selectedId;

  List<Candidate> presidentCandidates = [];
  List<Candidate> vicePresidentCandidates = [];
  List<Candidate> secretaryCandidates = [];
  List<Candidate> treasurerCandidates = [];
  List<Candidate> dataPrivacyCandidates = [];
  List<Candidate> itRepresentativeCandidates = [];
  List<Candidate> isRepresentativeCandidates = [];

  Future<void> fetchCandidates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? college = prefs.getString('college'); // Get the stored college

    if (college != null) {
      // Fetch candidates based on college
      final response = await http.get(
        Uri.parse(
            'http://localhost:8005/user/candidates/colleges?college=$college'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> candidatesJson = json.decode(response.body);
        setState(() {
          candidates = candidatesJson
              .map((json) => Candidate.fromJson(json))
              .toList(); // Convert JSON to Candidate objects

          // Clear previous lists
          presidentCandidates.clear();
          vicePresidentCandidates.clear();
          secretaryCandidates.clear();
          treasurerCandidates.clear();
          dataPrivacyCandidates.clear();
          itRepresentativeCandidates.clear();
          isRepresentativeCandidates.clear();

          // Categorize candidates by position
          for (var candidate in candidates) {
            switch (candidate.position) {
              case 'President':
                presidentCandidates.add(candidate);
                break;
              case 'Vice President':
                vicePresidentCandidates.add(candidate);
                break;
              case 'Secretary':
                secretaryCandidates.add(candidate);
                break;
              case 'Treasurer':
                treasurerCandidates.add(candidate);
                break;
              case 'Data Privacy Officer':
                dataPrivacyCandidates.add(candidate);
                break;
              case 'IT Representative':
                itRepresentativeCandidates.add(candidate);
                break;
              case 'IS Representative':
                isRepresentativeCandidates.add(candidate);
                break;
            }
          }
        });
      } else {
        throw Exception('Failed to load candidates: ${response.statusCode}');
      }
    } else {
      throw Exception('No college found in preferences');
    }
  }

  // Method to retrieve candidate name by ID
  String getCandidateNameById(int? candidateId) {
    if (candidateId != null) {
      for (var candidate in candidates) {
        // Search in the combined list
        if (candidate.candidateId == candidateId) {
          return candidate.name; // Return the name if found
        }
      }
    }
    return 'Not Selected'; // Return 'Not Selected' if no candidate found
  }

  @override
  void initState() {
    super.initState();
    fetchCandidates(); // Fetch candidates when the screen loads
  }

  @override
  void dispose() {
    // Clean up any resources if necessary
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      candidates: vicePresidentCandidates,
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
                      candidates: dataPrivacyCandidates,
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
                      candidates: itRepresentativeCandidates,
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
                      candidates: isRepresentativeCandidates,
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

                          if (selectedPresident == null &&
                              selectedVicePresident == null &&
                              selectedSecretary == null &&
                              selectedTreasurer == null &&
                              selectedDataPrivacy == null &&
                              selectedITRepresentative == null &&
                              selectedISRepresentative == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select at least one candidate before voting!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return; // Exit the method if no candidates are selected
                          }

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
                                onVotePressed: () async {
                                  // Retrieve student_id from shared preferences
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? studentIdString =
                                      prefs.getString('student_id');
                                  int studentId =
                                      int.tryParse(studentIdString ?? '') ??
                                          0; // Default to 0 if parsing fails

                                  // Define your selected candidates map
                                  final selectedCandidates = {
                                    'president_id':
                                        selectedPresident?.candidateId,
                                    'vice_president_id':
                                        selectedVicePresident?.candidateId,
                                    'secretary_id':
                                        selectedSecretary?.candidateId,
                                    'treasurer_id':
                                        selectedTreasurer?.candidateId,
                                    'data_privacy_id':
                                        selectedDataPrivacy?.candidateId,
                                    'itrepresentative_id':
                                        selectedITRepresentative?.candidateId,
                                    'isrepresentative_id':
                                        selectedISRepresentative?.candidateId,
                                    'election_id':
                                        selectedPresident?.electionId ?? 0,
                                    'student_id': studentId,
                                  };

                                  try {
                                    final response = await http.post(
                                      Uri.parse(
                                          'http://localhost:8005/user/votes'),
                                      headers: {
                                        'Content-Type': 'application/json',
                                      },
                                      body: json.encode(selectedCandidates),
                                    );

                                    print(
                                        'Request body: ${selectedCandidates}');

                                    if (response.statusCode == 201) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Vote successfully added!'),
                                          duration: Duration(seconds: 4),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } else if (response.statusCode == 409) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Yoou havea already voted!'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );

                                      Navigator.of(context).pop();
                                    } else {
                                      print('Error: ${response.statusCode}');
                                    }
                                  } catch (error) {
                                    print('Error occurred: $error');
                                  }
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
