import 'package:flutter/material.dart';
import 'package:voting_system/core/user_cred.dart';
import 'package:voting_system/screens/dashboard/studentDashboard/votingsystem_dashboard.dart';
import 'package:voting_system/widgets/login_dropdown.dart';
import 'package:voting_system/widgets/login_textformfield.dart';

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

  final List<String> options = [
    'College of Computer Study and Technology',
    'College of Engineering',
    'College of Tourism and Hospitality Management',
    'College of Accountancy'
  ];

  bool validateCredentials(String id, String name) {
    // Convert ID to integer for matching
    int? userID = int.tryParse(id);

    // Check if user exists with matching ID and name
    for (var user in sampleUser) {
      if (user['userID'] == userID && user['username'] == name) {
        return true;
      }
    }
    return false;
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
              width: 400,
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
                      options: options,
                      selectedValue: selectedValue, // Allow null initially
                      hintText:
                          'Choose an option', // Hint text will show initially
                      borderRadius: 12.0,
                      textStyle: const TextStyle(fontSize: 16),
                      onChanged: (value) {
                        setState(() {
                          selectedValue =
                              value; // Update selected value when chosen
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
                            String name = nameController.text;

                            // Check if credentials match the user list
                            if (validateCredentials(idNumber, name)) {
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
                                        child: Text("Invalid ID or name"))),
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
