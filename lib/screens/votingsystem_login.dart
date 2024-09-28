import 'dart:convert';
import 'package:http/http.dart' as http; // Import the http package
import 'package:flutter/material.dart';
import 'package:voting_system/core/models/college_model.dart';
import 'package:voting_system/screens/dashboard/studentDashboard/votingsystem_dashboard.dart';
import 'package:voting_system/screens/votingsystem_signup.dart';
import 'package:voting_system/widgets/login_dropdown.dart';
import 'package:voting_system/widgets/login_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VotingsystemLogin extends StatefulWidget {
  const VotingsystemLogin({super.key});

  @override
  State<VotingsystemLogin> createState() => _VotingsystemLoginState();
}

class _VotingsystemLoginState extends State<VotingsystemLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String? selectedValue; // Use String? to allow null value initially

  List<College> colleges = [];

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

  Future<bool> validateCredentials(String studentID, String college) async {
    try {
      // Send a GET request with student_id and college as query parameters
      final response = await http.get(
        Uri.parse(
            'http://localhost:8005/user/login?student_id=$studentID&college=$college'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> userJson = json.decode(response.body);

        if (userJson.isNotEmpty) {
          // Store studentID and college in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('student_id', studentID);
          await prefs.setString('college', college);

          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.05),
      body: Stack(
        children: [
          // Logo as the background
          Center(
            child: SizedBox(
              height: 700,
              width: 700,
              child: ClipOval(
                child: Image.asset(
                  'icons/plsp_logo.png', // Update with your logo path
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 500,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
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
                    const Text("Name"),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "Name",
                      prefixIcon: const Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
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
                              .firstWhere(
                                  (college) => college.collegeName == value)
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
                          if (formKey.currentState?.validate() == true) {
                            String idNumber = idNumberController.text;
                            String college = selectedValue ?? '';

                            // Call the validateCredentials function
                            bool isValid =
                                await validateCredentials(idNumber, college);

                            if (isValid) {
                              idNumberController.clear();
                              nameController.clear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VotingsystemDashboard()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Center(
                                        child: Text("Invalid ID or college"))),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account yet? ',
                            style: TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VotingsystemSignup()),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
