import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system/core/models/candidate_model.dart';
import 'package:http/http.dart' as http;
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
  bool isLoading = false;
  Candidate? selectedPresident;
  Candidate? selectedVicePresident;
  Candidate? selectedSecretary;
  Candidate? selectedTreasurer;
  Candidate? selectedDataPrivacy;
  Candidate? selectedITRepresentative;
  Candidate? selectedISRepresentative;
  int? selectedId;

  // Lists to store candidates for each position
  List<Candidate> allCandidates = [];
  List<Candidate> presidentCandidates = [];
  List<Candidate> vpresidentCandidates = [];
  List<Candidate> secretaryCandidates = [];
  List<Candidate> treasurerCandidates = [];
  List<Candidate> dataprivacyCandidates = [];
  List<Candidate> itrepresentativeCandidates = [];
  List<Candidate> isrepresentativeCandidates = [];

  @override
  void initState() {
    super.initState();
    fetchCandidates(); // Fetch candidates based on college
  }

  Future<void> fetchCandidates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? college = prefs.getString('college'); // Get the stored college

    if (college != null) {
      // Fetch candidates based on college
      final response = await http.get(
        Uri.parse('http://localhost:8005/user/candidates?college=$college'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> candidatesJson = json.decode(response.body);

        // Clear previous candidates
        presidentCandidates.clear();
        vpresidentCandidates.clear();
        secretaryCandidates.clear();
        treasurerCandidates.clear();
        dataprivacyCandidates.clear();
        itrepresentativeCandidates.clear();
        isrepresentativeCandidates.clear();
        allCandidates.clear(); // Clear previous combined list

        // Map candidates to their respective lists
        for (var candidateData in candidatesJson) {
          Candidate candidate = Candidate.fromJson(
              candidateData); // Make sure your Candidate model has a fromJson method

          // Add to combined list
          allCandidates.add(candidate);

          // Assign to respective lists based on position
          switch (candidate.position) {
            case 'President':
              presidentCandidates.add(candidate);
              break;
            case 'Vice President':
              vpresidentCandidates.add(candidate);
              break;
            case 'Secretary':
              secretaryCandidates.add(candidate);
              break;
            case 'Treasurer':
              treasurerCandidates.add(candidate);
              break;
            case 'Data Privacy Officer':
              dataprivacyCandidates.add(candidate);
              break;
            case 'IT Representative':
              itrepresentativeCandidates.add(candidate);
              break;
            case 'IS Representative':
              isrepresentativeCandidates.add(candidate);
              break;
            default:
          }
        }
        setState(
            () {}); // Call setState to update the UI with the new candidates
      } else {
        print('Failed to load candidates Voting line: ${response.statusCode}');
      }
    } else {
      print('No college found in preferences');
    }
  }

  // Method to retrieve candidate name by ID
  String getCandidateNameById(int? candidateId) {
    if (candidateId != null) {
      for (var candidate in allCandidates) {
        // Search in the combined list
        if (candidate.candidateId == candidateId) {
          return candidate.name; // Return the name if found
        }
      }
    }
    return 'Not Selected'; // Return 'Not Selected' if no candidate found
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
                    const SizedBox(height: 15),
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
                      candidates: dataprivacyCandidates,
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
                      candidate: allCandidates
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
