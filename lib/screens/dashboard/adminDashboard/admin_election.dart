// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_home.dart';
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

  // List<String> collages = ['CCST', 'COE', 'COA', 'CTHM', 'CON'];

  String? selectedItem = 'CCST'; // Default selected item
  final List<String> items = ['CCST', 'COE', 'COA', 'CTHM', 'CON'];

  List<TextEditingController> _controllersPres = [];
  List<Widget> _fieldsPres = [];
  List<TextEditingController> _controllersVice = [];
  List<Widget> _fieldsVice = [];
  List<TextEditingController> _controllersSec = [];
  List<Widget> _fieldsSec = [];
  List<TextEditingController> _controllersTre = [];
  List<Widget> _fieldsTre = [];
  List<TextEditingController> _controllersAud = [];
  List<Widget> _fieldsAud = [];
  List<TextEditingController> _controllersData = [];
  List<Widget> _fieldsData = [];
  List<TextEditingController> _controllersITR = [];
  List<Widget> _fieldsITR = [];
  List<TextEditingController> _controllersISR = [];
  List<Widget> _fieldsISR = [];

  void _addTextFieldPres() {
    // Create a new controller for each TextField
    TextEditingController _controllerPres = TextEditingController();
    _controllersPres.add(_controllerPres);
    setState(() {
      _fieldsPres.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerPres,
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: () {
                  print('object');
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
              ),
              labelText: 'Candidate ${_fieldsPres.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldPres() {
    if (_fieldsPres.isNotEmpty && _controllersPres.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsPres.removeLast();
        _controllersPres.removeLast();
      });
    }
  }

  void _addTextFieldVice() {
    // Create a new controller for each TextField
    TextEditingController _controllerVice = TextEditingController();
    _controllersVice.add(_controllerVice);

    setState(() {
      _fieldsVice.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerVice,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsVice.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldVice() {
    if (_fieldsVice.isNotEmpty && _controllersVice.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsVice.removeLast();
        _controllersVice.removeLast();
      });
    }
  }

  void _addTextFieldSec() {
    // Create a new controller for each TextField
    TextEditingController _controllerSec = TextEditingController();
    _controllersSec.add(_controllerSec);

    setState(() {
      _fieldsSec.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerSec,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsSec.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldSec() {
    if (_fieldsSec.isNotEmpty && _controllersSec.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsSec.removeLast();
        _controllersSec.removeLast();
      });
    }
  }

  void _addTextFieldTre() {
    // Create a new controller for each TextField
    TextEditingController _controllerTre = TextEditingController();
    _controllersTre.add(_controllerTre);

    setState(() {
      _fieldsTre.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerTre,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsTre.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldTre() {
    if (_fieldsTre.isNotEmpty && _controllersTre.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsTre.removeLast();
        _controllersTre.removeLast();
      });
    }
  }

  void _addTextFieldAud() {
    // Create a new controller for each TextField
    TextEditingController _controllerAud = TextEditingController();
    _controllersAud.add(_controllerAud);

    setState(() {
      _fieldsAud.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerAud,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsAud.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldAud() {
    if (_fieldsAud.isNotEmpty && _controllersAud.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsAud.removeLast();
        _controllersAud.removeLast();
      });
    }
  }

  void _addTextFieldData() {
    // Create a new controller for each TextField
    TextEditingController _controllerData = TextEditingController();
    _controllersData.add(_controllerData);

    setState(() {
      _fieldsData.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerData,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsData.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldData() {
    if (_fieldsData.isNotEmpty && _controllersData.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsData.removeLast();
        _controllersData.removeLast();
      });
    }
  }

  void _addTextFieldITR() {
    // Create a new controller for each TextField
    TextEditingController _controllerITR = TextEditingController();
    _controllersITR.add(_controllerITR);

    setState(() {
      _fieldsITR.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerITR,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsITR.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldITR() {
    if (_fieldsITR.isNotEmpty && _controllersITR.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsITR.removeLast();
        _controllersITR.removeLast();
      });
    }
  }

  void _addTextFieldISR() {
    // Create a new controller for each TextField
    TextEditingController _controllerISR = TextEditingController();
    _controllersISR.add(_controllerISR);

    setState(() {
      _fieldsISR.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllerISR,
            decoration: InputDecoration(
              labelText: 'Candidate ${_fieldsISR.length + 1}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    });
  }

  void _removeTextFieldISR() {
    if (_fieldsISR.isNotEmpty && _controllersISR.isNotEmpty) {
      // Remove the last text field and its controller
      setState(() {
        _fieldsISR.removeLast();
        _controllersISR.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // sectionone
          //     ?
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create an Election:',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: selectedItem,
                          onChanged: (newValue) {
                            setState(() {
                              selectedItem = newValue;
                            });
                          },
                          items: items.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  CustomContainerWidget(
                    positionText: 'President',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldPres();
                    },
                    onAction2Tap: () {
                      _removeTextFieldPres();
                    },
                    fields: _fieldsPres,
                  ),
                  CustomContainerWidget(
                    positionText: 'Vice President',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldVice();
                    },
                    onAction2Tap: () {
                      _removeTextFieldVice();
                    },
                    fields: _fieldsVice,
                  ),
                  CustomContainerWidget(
                    positionText: 'Secretary',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldSec();
                    },
                    onAction2Tap: () {
                      _removeTextFieldSec();
                    },
                    fields: _fieldsSec,
                  ),
                  CustomContainerWidget(
                    positionText: 'Treasurer',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldTre();
                    },
                    onAction2Tap: () {
                      _removeTextFieldTre();
                    },
                    fields: _fieldsTre,
                  ),
                  CustomContainerWidget(
                    positionText: 'Auditor',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldAud();
                    },
                    onAction2Tap: () {
                      _removeTextFieldAud();
                    },
                    fields: _fieldsAud,
                  ),
                  CustomContainerWidget(
                    positionText: 'Data Privacy',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldData();
                    },
                    onAction2Tap: () {
                      _removeTextFieldData();
                    },
                    fields: _fieldsData,
                  ),
                  CustomContainerWidget(
                    positionText: 'IT Representative',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldITR();
                    },
                    onAction2Tap: () {
                      _removeTextFieldITR();
                    },
                    fields: _fieldsITR,
                  ),
                  CustomContainerWidget(
                    positionText: 'IS Representative',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addTextFieldISR();
                    },
                    onAction2Tap: () {
                      _removeTextFieldISR();
                    },
                    fields: _fieldsISR,
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       for (int i = 0; i < _controllersPres.length; i++) {
                  //         print(
                  //             'Candidate ${i + 1}: ${_controllersPres[i].text}');
                  //       }
                  //     },
                  //     child: Text('data'))
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (sectiontwo)
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

class CustomContainerWidget extends StatelessWidget {
  final String positionText;
  final String action1Text;
  final String action2Text;
  final VoidCallback onAction1Tap;
  final VoidCallback onAction2Tap;
  final List<Widget> fields;

  const CustomContainerWidget({
    Key? key,
    required this.positionText,
    required this.action1Text,
    required this.action2Text,
    required this.onAction1Tap,
    required this.onAction2Tap,
    required this.fields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(positionText),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onAction1Tap,
                      child: Container(
                        child: Text(action1Text),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: onAction2Tap,
                      child: Container(
                        child: Text(action2Text),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Column(
              children: fields,
            ),
          ),
        ],
      ),
    );
  }
}
