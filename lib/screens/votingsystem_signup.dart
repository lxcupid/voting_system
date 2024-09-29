import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:voting_system/core/models/college_model.dart';
import 'package:voting_system/core/models/user_model.dart';
import 'dart:convert'; // For JSON encoding
import 'package:voting_system/screens/votingsystem_verifyotp.dart';
import 'package:voting_system/widgets/login_dropdown.dart';
import 'package:voting_system/widgets/login_textformfield.dart';
import 'global.dart' as globals; // Import the globals file

class VotingsystemSignup extends StatefulWidget {
  const VotingsystemSignup({super.key});

  @override
  State<VotingsystemSignup> createState() => _VotingsystemSignupState();
}

class _VotingsystemSignupState extends State<VotingsystemSignup> {
  final formKey1 = GlobalKey<FormState>();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController mnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? selectedValue;
  List<College> colleges = []; // List to hold college data

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

  Future<void> createUser() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8005/user'), // Replace with your endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'student_id': int.parse(idNumberController.text),
          'fname': fnameController.text,
          'mname': mnameController.text,
          'lname': lnameController.text,
          'email': emailController.text,
          'college': selectedValue,
        }),
      );

      globals.globalEmail =
          emailController.text; // Set the global email variable

      if (response.statusCode == 201) {
        // Navigate to Verify OTP screen with email
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VotingsystemVerifyotp(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(),
              child: AlertDialog(
                title: const Text(
                  "Failed",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text("User already Exist"),
                actions: <Widget>[
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Ok",
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
            );
          },
        );
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 600,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Form(
                          key: formKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              const Text("ID Number"),
                              const SizedBox(height: 5),
                              CustomTextFormField(
                                controller: idNumberController,
                                hintText: "ID Number",
                                prefixIcon: const Icon(Icons.person),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "ID cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text("Last Name"),
                              const SizedBox(height: 5),
                              CustomTextFormField(
                                controller: lnameController,
                                hintText: "Last Name",
                                prefixIcon: const Icon(Icons.person),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Last name cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text("First Name"),
                              const SizedBox(height: 5),
                              CustomTextFormField(
                                controller: fnameController,
                                hintText: "First Name",
                                prefixIcon: const Icon(Icons.person),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const Text("Middle Name"),
                              const SizedBox(height: 5),
                              CustomTextFormField(
                                controller: mnameController,
                                hintText: "Middle Name",
                                prefixIcon: const Icon(Icons.person),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Middle Name cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text("Email"),
                              const SizedBox(height: 5),
                              CustomTextFormField(
                                controller: emailController,
                                hintText: "Email",
                                prefixIcon: const Icon(Icons.email),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  // Regular expression for validating email format
                                  final RegExp emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                  );
                                  if (!emailRegex.hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text("Colleges"),
                              const SizedBox(height: 5),
                              CustomDropdown(
                                options: colleges
                                    .map((college) => college.collegeName)
                                    .toList(),
                                selectedValue: selectedValue,
                                hintText: 'Choose an option',
                                borderRadius: 12.0,
                                textStyle: const TextStyle(fontSize: 16),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = colleges
                                        .firstWhere((college) =>
                                            college.collegeName == value)
                                        .collegeId;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (formKey1.currentState?.validate() ==
                                        true) {
                                      // Call the createUser function to send data
                                      await createUser();
                                    }
                                  },
                                  child: const Text(
                                    "Sign Up",
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
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                color: Colors.green,
                child: Image.asset('icons/plsp_logo1.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
