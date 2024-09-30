import 'dart:convert'; // For base64Encode
import 'dart:io'; // For File
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Importing FilePicker
import 'package:voting_system/core/models/college_model.dart';
import 'package:voting_system/widgets/login_dropdown.dart';
import 'package:voting_system/widgets/login_textformfield.dart';

class AdminAddElection extends StatefulWidget {
  const AdminAddElection({super.key});

  @override
  State<AdminAddElection> createState() => _AdminAddElectionState();
}

class _AdminAddElectionState extends State<AdminAddElection> {
  String? selectedValue; // College
  String? selectedPosition; // Candidate Position
  TextEditingController nameController = TextEditingController();
  TextEditingController electionIDController = TextEditingController();
  TextEditingController mottoController = TextEditingController();
  File? _imageFile; // To store the selected image file
  String? _base64Image; // To store the Base64 string of the image

  List<College> colleges = [];

  List<String> positions = [
    "President",
    "Vice President",
    "Secretary",
    "Treasurer",
    "Data Privacy Officer",
    "IT Representative",
    "IS Representative",
  ];

  @override
  void initState() {
    super.initState();
    fetchColleges(); // Fetch colleges on init
  }

  Future<void> fetchColleges() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8005/user/colleges'));

      if (response.statusCode == 200) {
        final List<dynamic> collegeJson = json.decode(response.body);
        setState(() {
          colleges = collegeJson.map((json) => College.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load colleges');
      }
    } catch (e) {
      print('Error fetching colleges: $e');
    }
  }

  Future<void> _addCandidate() async {
    if (selectedValue == null ||
        selectedPosition == null ||
        nameController.text.isEmpty ||
        _base64Image == null) {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Prepare the candidate data
    final candidateData = {
      "fullname": nameController.text,
      "position": selectedPosition,
      "motto": mottoController.text, // Use the text value
      "college": selectedValue,
      "election_id": electionIDController.text, // Use the text value
      "image": _base64Image,
    };

    print("Candidate Data: ${json.encode(candidateData)}");

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8005/user/candidates'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(candidateData),
      );

      if (response.statusCode == 201) {
        // Successfully added candidate
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Candidate added successfully")),
        );
        // Optionally clear fields or navigate
        nameController.clear();
        setState(() {
          selectedValue = null;
          selectedPosition = null;
          _imageFile = null;
          _base64Image = null;
        });
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add candidate: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error adding candidate: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error adding candidate")),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        // Check if the platform is web and handle accordingly
        if (kIsWeb) {
          // For web, get the bytes directly
          final bytes = result.files.first.bytes;
          if (bytes != null) {
            // Convert bytes to Base64
            _base64Image = base64Encode(bytes);
            setState(() {
              _imageFile = null; // You won't have a File object for web
            });
          }
        } else {
          // For other platforms (e.g., Windows), use path to get the file
          setState(() {
            _imageFile = File(result.files.first.path!);
          });
          // Convert image file to Base64
          final bytes = await _imageFile!.readAsBytes();
          _base64Image = base64Encode(bytes);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 400,
                        child: CustomDropdown(
                          backgroundColor: Colors.grey[100],
                          options: colleges
                              .map((college) => college.collegeName)
                              .toList(),
                          selectedValue: selectedValue,
                          hintText: 'Select College',
                          borderRadius: 12.0,
                          textStyle: const TextStyle(fontSize: 16),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = colleges
                                  .firstWhere(
                                      (college) => college.collegeName == value)
                                  .collegeId;

                              if (selectedValue != null) {
                                int currentYear =
                                    DateTime.now().year; // Get the current year
                                electionIDController.text =
                                    '${selectedValue}$currentYear'; // Format the ID with an underscore or any delimiter
                              } else {
                                electionIDController
                                    .clear(); // Clear the field if no college is selected
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    const Text("Election name/year"),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      fillColor: Colors.grey[100],
                      controller: electionIDController,
                      hintText: "Election Name/year",
                      readOnly: true, // Make the field read-only
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Election Name/year cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        "Select Candidate",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("Candidate Name"),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      fillColor: Colors.grey[100],
                      controller: nameController,
                      hintText: "Candidate name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Candidate name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text("Candidate Motto"),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      fillColor: Colors.grey[100],
                      controller: mottoController,
                      hintText: "Candidate Motto",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Candidate Motto cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text("Select Candidate Position"),
                    const SizedBox(height: 5),
                    CustomDropdown(
                      backgroundColor: Colors.grey[100],
                      options: positions,
                      selectedValue: selectedPosition,
                      hintText: 'Select Position',
                      borderRadius: 12.0,
                      textStyle: const TextStyle(fontSize: 16),
                      onChanged: (value) {
                        setState(() {
                          selectedPosition =
                              value; // Assigning the selected position value
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Upload Candidate Photo"),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Pick Image"),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          _addCandidate();
                        },
                        child: const Text(
                          "Add Candidate",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: _imageFile != null || _base64Image != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Check if it's a web app or a regular platform
                          if (kIsWeb && _base64Image != null)
                            Image.memory(
                              base64Decode(_base64Image!),
                              height: 250,
                              width: 200,
                            )
                          else if (_imageFile != null)
                            Image.file(
                              _imageFile!,
                              height: 100,
                            ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Center(child: Image.asset('icons/plsp_logo1.png')),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
