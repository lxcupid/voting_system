import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:http/http.dart' as http;
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/custom_container_widget.dart';

void fetchCollegeNames(List<String> collegeNames, Function updateState) async {
  final String baseUrl = 'http://localhost:8005/user/colleges';

  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    collegeNames.clear(); // Clear existing data

    // Extract and add only college names to the list
    for (var item in jsonList) {
      collegeNames.add(item['college_name']);
    }

    // Call updateState to rebuild the widget with new data
    updateState();
  } else {
    print('Failed to load colleges. Status code: ${response.statusCode}');
  }
}

class Candidate {
  String fullname;
  String motto;
  String college;
  String position;
  String electionId;
  String? image; // Use Uint8List for web; adjust as needed for other platforms

  Candidate({
    required this.fullname,
    required this.motto,
    required this.college,
    required this.position,
    required this.electionId,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "motto": motto,
      "college": college,
      "position": position,
      "election_id": electionId,
      "image": image,
    };
  }
}

class AdminElection extends StatefulWidget {
  const AdminElection({super.key});

  @override
  State<AdminElection> createState() => _AdminElectionState();
}

class _AdminElectionState extends State<AdminElection> {
  List<Candidate> candidates = [];

  String? selectedCollege =
      'College of Computer Studies and Technology'; // Variable to store the selected college

  // Define controllers and fields for each position
  List<Widget> _fieldsPres = [];
  List<TextEditingController> _controllersVice = [];
  List<Widget> _fieldsVice = [];
  List<TextEditingController> _controllersSec = [];
  List<Widget> _fieldsSec = [];
  List<TextEditingController> _controllersTre = [];
  List<Widget> _fieldsTre = [];
  List<TextEditingController> _controllersAud = [];
  List<Widget> _fieldsAud = [];
  List<TextEditingController> _controllersData = [];
  List<Widget> _fieldsData = [];
  List<TextEditingController> _controllersITR = [];
  List<Widget> _fieldsITR = [];
  List<TextEditingController> _controllersISR = [];
  List<Widget> _fieldsISR = [];

  final TextEditingController _title = TextEditingController();

  List<String> collegeNames = []; // List to store college names

  @override
  void initState() {
    super.initState();
    _initializeFields(); // Initialize with 3 fields for each position.
  }

  void _initializeFields() {
    _addThreeTextFieldsPres();
    _addThreeTextFieldsVice();
    _addThreeTextFieldsSec();
    _addThreeTextFieldsTre();
    _addThreeTextFieldsAud();
    _addThreeTextFieldsData();
    _addThreeTextFieldsITR();
    _addThreeTextFieldsISR();
    fetchCollegeNames(collegeNames, () {
      setState(() {
        // Loading state
      }); // Update the UI when data is fetched
    });
  }

  List<Map<String, dynamic>> _candidatesData =
      []; // List to store candidate data (controllers and images)

  Future<void> submitCandidates() async {
    final String apiUrl = 'http://localhost:8005/user/candidates';

    for (var candidate in candidates) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode(candidate.toJson()), // Ensure toJson exists and works
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Candidate successfully submitted!")),
          );
          print("Candidate submitted: ${response.body}");
        } else {
          print("Failed to submit candidate: ${response.statusCode}");
        }
      } catch (e) {
        print("Error submitting candidate: $e");
      }
    }
  }

  void _addThreeTextFieldsPres() {
    // Use a single set of controllers and a stateful widget to store data
    TextEditingController _fullnameController = TextEditingController();
    TextEditingController _mottoController = TextEditingController();

    // Store selected image data
    File? selectedImage;
    Uint8List? selectedWebImage; // For web

    // Function to check and add candidate automatically
    void _checkAndAddCandidate() {
      if (_fullnameController.text.isNotEmpty &&
          _mottoController.text.isNotEmpty) {
        // Add the candidate to the list
        setState(() {
          candidates.add(
            Candidate(
              fullname: _fullnameController.text,
              motto: _mottoController.text,
              college: 'CCST',
              position: "President", // Use appropriate position
              electionId: '1029',
              image: selectedWebImage != null
                  ? base64Encode(selectedWebImage!)
                  : (selectedImage != null
                      ? base64Encode(selectedImage!.readAsBytesSync())
                      : null), // Convert image bytes to base64 string
            ),
          );
        });
      } else {
        // Optionally show a message to fill in the required fields
        print('Please fill in the fullname and motto fields');
      }
    }

    setState(() {
      _fieldsPres.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  labelText: 'Candidate Fullname',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  // Optionally trigger check when typing
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _mottoController,
                decoration: InputDecoration(
                  labelText: 'Motto',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  // Optionally trigger check when typing
                },
              ),
              StatefulBuilder(builder: (context, setStateImage) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(7),
                        backgroundColor: Colors.green[300],
                        foregroundColor: Colors.black, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () async {
                        if (kIsWeb) {
                          // Web: Select and handle image as Uint8List
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: false,
                          );

                          if (result != null) {
                            selectedWebImage = result.files.first.bytes;

                            // Update the image without replacing the button
                            setStateImage(() {});

                            // Automatically check and add the candidate
                            _checkAndAddCandidate();
                          }
                        } else {
                          // Desktop (Windows): Select and handle image as File
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: false,
                          );

                          if (result != null) {
                            selectedImage = File(result.files.single.path!);

                            // Update the image without replacing the button
                            setStateImage(() {});

                            // Automatically check and add the candidate
                            _checkAndAddCandidate();
                          }
                        }
                      },
                      child: Text('Pick Candidate Image'),
                    ),
                    SizedBox(height: 10),
                    // Display the selected image or a placeholder
                    if (kIsWeb && selectedWebImage != null)
                      Image.memory(
                        selectedWebImage!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    else if (!kIsWeb && selectedImage != null)
                      Image.file(
                        selectedImage!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    else
                      Text('No image selected'),
                  ],
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  void _removeThreeTextFieldsPres() {
    if (_fieldsPres.length >= 3) {
      setState(() {
        // Remove the last entry in the _fieldsPres list (fullname, motto, and button)
        _fieldsPres.removeLast();
        _fieldsPres.removeLast();
        _fieldsPres.removeLast();

        // Remove the last corresponding controllers and image data from _candidatesData
        _candidatesData.removeLast();
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each Vice candidate
  void _addThreeTextFieldsVice() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerVice = TextEditingController();
      _controllersVice.add(_controllerVice);

      // Separate variables to store image data for web and desktop
      File? selectedViceImage;
      Uint8List? selectedViceWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsVice.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsVice.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerVice,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 != 0) // Button and image picker only for 'Vice Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedViceWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedViceImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedViceWebImage != null)
                          Image.memory(
                            selectedViceWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedViceImage != null)
                          Image.file(
                            selectedViceImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Vice President
  void _removeThreeTextFieldsVice() {
    if (_fieldsVice.length >= 2) {
      setState(() {
        _fieldsVice.removeRange(_fieldsVice.length - 2, _fieldsVice.length);
        _controllersVice.removeRange(
            _controllersVice.length - 2, _controllersVice.length);
      });
    }
  }

// Function to add 2 text fields and an image picker button for each Secretary candidate
  void _addThreeTextFieldsSec() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerSec = TextEditingController();
      _controllersSec.add(_controllerSec);

      // Separate variables to store image data for web and desktop
      File? selectedSecImage;
      Uint8List? selectedSecWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsSec.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsSec.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerSec,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Secretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedSecWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedSecImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedSecWebImage != null)
                          Image.memory(
                            selectedSecWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedSecImage != null)
                          Image.file(
                            selectedSecImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Secretary
  void _removeThreeTextFieldsSec() {
    if (_fieldsSec.length >= 2) {
      setState(() {
        _fieldsSec.removeRange(_fieldsSec.length - 2, _fieldsSec.length);
        _controllersSec.removeRange(
            _controllersSec.length - 2, _controllersSec.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each Treretary candidate
  void _addThreeTextFieldsTre() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerTre = TextEditingController();
      _controllersTre.add(_controllerTre);

      // Separate variables to store image data for web and desktop
      File? selectedTreImage;
      Uint8List? selectedTreWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsTre.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsTre.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerTre,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Treretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedTreWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedTreImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedTreWebImage != null)
                          Image.memory(
                            selectedTreWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedTreImage != null)
                          Image.file(
                            selectedTreImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Treasurer
  void _removeThreeTextFieldsTre() {
    if (_fieldsTre.length >= 2) {
      setState(() {
        _fieldsTre.removeRange(_fieldsTre.length - 2, _fieldsTre.length);
        _controllersTre.removeRange(
            _controllersTre.length - 2, _controllersTre.length);
      });
    }
  }

// Function to add 2 text fields and an image picker button for each Audretary candidate
  void _addThreeTextFieldsAud() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerAud = TextEditingController();
      _controllersAud.add(_controllerAud);

      // Separate variables to store image data for web and desktop
      File? selectedAudImage;
      Uint8List? selectedAudWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsAud.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsAud.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerAud,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Audretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedAudWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedAudImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedAudWebImage != null)
                          Image.memory(
                            selectedAudWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedAudImage != null)
                          Image.file(
                            selectedAudImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Auditor
  void _removeThreeTextFieldsAud() {
    if (_fieldsAud.length >= 2) {
      setState(() {
        _fieldsAud.removeRange(_fieldsAud.length - 2, _fieldsAud.length);
        _controllersAud.removeRange(
            _controllersAud.length - 2, _controllersAud.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each Dataretary candidate
  void _addThreeTextFieldsData() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerData = TextEditingController();
      _controllersData.add(_controllerData);

      // Separate variables to store image data for web and desktop
      File? selectedDataImage;
      Uint8List? selectedDataWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsData.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsData.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerData,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Dataretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedDataWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedDataImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedDataWebImage != null)
                          Image.memory(
                            selectedDataWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedDataImage != null)
                          Image.file(
                            selectedDataImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Data Representative
  void _removeThreeTextFieldsData() {
    if (_fieldsData.length >= 2) {
      setState(() {
        _fieldsData.removeRange(_fieldsData.length - 2, _fieldsData.length);
        _controllersData.removeRange(
            _controllersData.length - 2, _controllersData.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each ITRretary candidate
  void _addThreeTextFieldsITR() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerITR = TextEditingController();
      _controllersITR.add(_controllerITR);

      // Separate variables to store image ITR for web and desktop
      File? selectedITRImage;
      Uint8List? selectedITRWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsITR.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsITR.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerITR,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'ITRretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedITRWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedITRImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedITRWebImage != null)
                          Image.memory(
                            selectedITRWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedITRImage != null)
                          Image.file(
                            selectedITRImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for IT Representative
  void _removeThreeTextFieldsITR() {
    if (_fieldsITR.length >= 2) {
      setState(() {
        _fieldsITR.removeRange(_fieldsITR.length - 2, _fieldsITR.length);
        _controllersITR.removeRange(
            _controllersITR.length - 2, _controllersITR.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each ISRretary candidate
  void _addThreeTextFieldsISR() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerISR = TextEditingController();
      _controllersISR.add(_controllerISR);

      // Separate variables to store image ISR for web and desktop
      File? selectedISRImage;
      Uint8List? selectedISRWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsISR.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsISR.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerISR,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'ISRretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedISRWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedISRImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedISRWebImage != null)
                          Image.memory(
                            selectedISRWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedISRImage != null)
                          Image.file(
                            selectedISRImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for ISR
  void _removeThreeTextFieldsISR() {
    if (_fieldsISR.length >= 2) {
      setState(() {
        _fieldsISR.removeRange(_fieldsISR.length - 2, _fieldsISR.length);
        _controllersISR.removeRange(
            _controllersISR.length - 2, _controllersISR.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Display loading indicator if collegeNames is empty
          if (collegeNames.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else // If collegeNames is not empty, display the rest of the UI
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Create an Election:',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 215, 215),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton<String>(
                              value: selectedCollege,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCollege = newValue;
                                });
                              },
                              items: collegeNames.map<DropdownMenuItem<String>>(
                                  (String collegeName) {
                                return DropdownMenuItem(
                                  value: collegeName,
                                  child: Text(collegeName),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _title,
                        decoration: InputDecoration(
                          labelText: 'Election Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomContainerWidget(
                      positionText: 'President',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsPres();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsPres();
                      },
                      fields: _fieldsPres,
                    ),
                    CustomContainerWidget(
                      positionText: 'Vice President',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsVice();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsVice();
                      },
                      fields: _fieldsVice,
                    ),
                    CustomContainerWidget(
                      positionText: 'Secretary',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsSec();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsSec();
                      },
                      fields: _fieldsSec,
                    ),
                    CustomContainerWidget(
                      positionText: 'Treasurer',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsTre();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsTre();
                      },
                      fields: _fieldsTre,
                    ),
                    CustomContainerWidget(
                      positionText: 'Auditor',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsAud();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsAud();
                      },
                      fields: _fieldsAud,
                    ),
                    CustomContainerWidget(
                      positionText: 'Data Privacy',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsData();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsData();
                      },
                      fields: _fieldsData,
                    ),
                    CustomContainerWidget(
                      positionText: 'IT Representative',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsITR();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsITR();
                      },
                      fields: _fieldsITR,
                    ),
                    CustomContainerWidget(
                      positionText: 'IS Representative',
                      action1Text: 'Add Candidate',
                      action2Text: 'Remove Textfield',
                      onAction1Tap: () {
                        _addThreeTextFieldsISR();
                      },
                      onAction2Tap: () {
                        _removeThreeTextFieldsISR();
                      },
                      fields: _fieldsISR,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(candidates);
                        submitCandidates();
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[300]),
                        child: Text('Create An Election',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
