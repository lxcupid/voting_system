import 'package:flutter/material.dart';

class CreateElection extends StatefulWidget {
  const CreateElection({super.key});

  @override
  State<CreateElection> createState() => _CreateElectionState();
}

class _CreateElectionState extends State<CreateElection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 2000,
              color: Colors.red,
            )
          ],
        ),
      )),
    );
  }
}
