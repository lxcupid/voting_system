import 'package:flutter/material.dart';
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

  int selectedOptionIndex = 0; // Use an index to track the selected option

  final List<String> options = [
    'College of Computer Study and Tecnhnology',
    'Computer of Engineering',
    'Collge of Tourism and Hospitality Management',
    'College of Accountancy'
  ];

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
                    Text("ID Number"),
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
                    Text("Colleges"),
                    SizedBox(height: 5),
                    CustomDropdown(
                      options: options,
                      selectedValue: options[
                          selectedOptionIndex], // Use the selected index to get the string
                      hintText: 'Choose an option',
                      borderRadius: 12.0,
                      textStyle: TextStyle(fontSize: 16),
                      onChanged: (value) {
                        setState(() {
                          selectedOptionIndex = options
                              .indexOf(value!); // Update the selected index
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VotingsystemDashboard()),
                          );

                          // if (formKey.currentState?.validate() == true) {
                          //   print("Login Clicked");
                          //   print(
                          //       "Selected Option: ${options[selectedOptionIndex]}"); // Print selected option
                          // }
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
