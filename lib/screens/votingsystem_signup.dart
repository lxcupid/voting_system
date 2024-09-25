import 'package:flutter/material.dart';
import 'package:voting_system/screens/votingsystem_verifyotp.dart';
import 'package:voting_system/widgets/login_dropdown.dart';
import 'package:voting_system/widgets/login_textformfield.dart';

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

  String? selectedValue; // Use String? to allow null value initially

  final List<String> options = [
    'College of Computer Study and Technology',
    'College of Engineering',
    'College of Tourism and Hospitality Management',
    'College of Accountancy'
  ];

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
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text("Colleges"),
                              const SizedBox(height: 5),
                              CustomDropdown(
                                options: options,
                                selectedValue:
                                    selectedValue, // Allow null initially
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
                                    if (formKey1.currentState?.validate() ==
                                        true) {
                                      String idNumber = idNumberController.text;
                                      String fname = fnameController.text;
                                      String lname = lnameController.text;
                                      String mname = mnameController.text;
                                      String email = emailController.text;

                                      // Check if credentials match the user list
                                      if (idNumber.isEmpty ||
                                          fname.isEmpty ||
                                          lname.isEmpty ||
                                          mname.isEmpty ||
                                          email.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Center(
                                                  child: Text(
                                                      "Invalid ID or name"))),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Center(
                                                  child: Text(
                                                      "Login Successfully"))),
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VotingsystemVerifyotp()),
                                        );
                                      }
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
                          )),
                    )
                  ],
                ),
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.green,
              child: Image.asset('icons/plsp_logo1.png'),
            ))
          ],
        ),
      ),
    );
  }
}
