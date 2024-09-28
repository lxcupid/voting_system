import 'package:flutter/material.dart';
import 'package:voting_system/screens/votingsystem_login.dart';
import 'package:voting_system/widgets/login_textformfield.dart';

class VotingsystemVerifyotp extends StatefulWidget {
  const VotingsystemVerifyotp({super.key});

  @override
  State<VotingsystemVerifyotp> createState() => _VotingsystemVerifyotpState();
}

class _VotingsystemVerifyotpState extends State<VotingsystemVerifyotp> {
  final formKey1 = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

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

                                    // Check if credentials match the user list
                                    if (otp.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Center(
                                                child: Text("Invalid OTP"))),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const VotingsystemLogin()),
                                      );
                                    }
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
