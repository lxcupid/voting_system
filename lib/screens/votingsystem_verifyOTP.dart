import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:voting_system/screens/votingsystem_login.dart';
import 'package:voting_system/widgets/login_textformfield.dart';
import 'global.dart' as globals; // Import the globals file

class VotingsystemVerifyotp extends StatefulWidget {
  const VotingsystemVerifyotp({
    super.key,
  });

  @override
  State<VotingsystemVerifyotp> createState() => _VotingsystemVerifyotpState();
}

class _VotingsystemVerifyotpState extends State<VotingsystemVerifyotp> {
  final formKey1 = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  Future<void> verifyOtp(String otp) async {
    final url = Uri.parse(
        'http://localhost:8005/user/verify-otp'); // Replace with your actual API endpoint
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type
      },
      body: jsonEncode({
        'email': globals.globalEmail,
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      // OTP verified successfully
      // Show success dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(),
            child: AlertDialog(
              title: const Text(
                "Success",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text("Sign Up Successful"),
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

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VotingsystemLogin()),
                      );
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
    } else {
      // OTP verification failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Center(child: Text("Invalid OTP"))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'VERIFY OTP',
                    style: const TextStyle(
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
                            CustomTextFormField(
                              controller: otpController,
                              hintText: "",
                              prefixIcon: const Icon(Icons.lock),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "OTP cannot be empty";
                                }
                                return null;
                              },
                              hasBottomBorder: true,
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
                                    String otp = otpController.text;

                                    // Call the verifyOtp function
                                    await verifyOtp(
                                        otp); // Use widget.email here
                                  }
                                },
                                child: const Text(
                                  "Verify",
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
