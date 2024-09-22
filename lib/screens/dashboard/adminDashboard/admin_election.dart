import 'package:flutter/material.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/create_election.dart';
import 'package:voting_system/widgets/dialogbox.dart';

class AdminElection extends StatefulWidget {
  const AdminElection({super.key});

  @override
  State<AdminElection> createState() => _AdminElectionState();
}

void function() {
  print('object');
}

class _AdminElectionState extends State<AdminElection> {
  bool sectionone = true;
  bool sectiontwo = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          sectionone
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(20, (index) {
                        return GestureDetector(
                          onTap: () {
                            // Handle tap event
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Election Title $index'),
                                    Text('text here $index'),
                                    Text('Date time sched $index'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          showCustomDialog(context,
                                              onConfirm: function,
                                              title: 'Delete an Election.',
                                              message:
                                                  'Delete the Selected Election.');
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              : const Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      //scrren for title and candidates
                    ],
                  )),
                ),
          const SizedBox(height: 10),
          if (sectionone)
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    toggleScreen();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(20)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 0, 0),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green[300]!,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Create an Election',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (sectiontwo)
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        toggleScreen();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 0, 0, 0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green[300]!,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Return',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green[300]!,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Add Candidate',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green[300]!,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Proceed',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void toggleScreen() {
    setState(() {
      sectionone = !sectionone;
      sectiontwo = !sectiontwo;
    });
  }
}
