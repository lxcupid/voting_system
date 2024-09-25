import 'package:flutter/material.dart';

class AdminElection extends StatefulWidget {
  const AdminElection({super.key});

  @override
  State<AdminElection> createState() => _AdminElectionState();
}

class _AdminElectionState extends State<AdminElection> {
  String? selectedItem = 'CCST'; // Default selected item
  final List<String> items = ['CCST', 'COE', 'COA', 'CTHM', 'CON'];

  // Define controllers and fields for each position
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

  @override
  void initState() {
    super.initState();
    _initializeFields(); // Initialize with 3 fields for each position.
  }

  void _initializeFields() {
    _addThreeTextFieldsPres();
    _addThreeTextFieldsVice();
    _addThreeTextFieldsSec();
    _addThreeTextFieldsTre();
    _addThreeTextFieldsAud();
    _addThreeTextFieldsData();
    _addThreeTextFieldsITR();
    _addThreeTextFieldsISR();
  }

  // Function to add 3 text fields for President
  void _addThreeTextFieldsPres() {
    for (int i = 0; i < 3; i++) {
      TextEditingController _controllerPres = TextEditingController();
      _controllersPres.add(_controllerPres);
      setState(() {
        _fieldsPres.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: _controllerPres,
              decoration: InputDecoration(
                labelText: 'Candidate ${_fieldsPres.length + 1}',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for President
  void _removeThreeTextFieldsPres() {
    if (_fieldsPres.length >= 3) {
      setState(() {
        _fieldsPres.removeRange(_fieldsPres.length - 3, _fieldsPres.length);
        _controllersPres.removeRange(
            _controllersPres.length - 3, _controllersPres.length);
      });
    }
  }

  // Function to add 3 text fields for Vice President
  void _addThreeTextFieldsVice() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for Vice President
  void _removeThreeTextFieldsVice() {
    if (_fieldsVice.length >= 3) {
      setState(() {
        _fieldsVice.removeRange(_fieldsVice.length - 3, _fieldsVice.length);
        _controllersVice.removeRange(
            _controllersVice.length - 3, _controllersVice.length);
      });
    }
  }

  // Function to add 3 text fields for Secretary
  void _addThreeTextFieldsSec() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for Secretary
  void _removeThreeTextFieldsSec() {
    if (_fieldsSec.length >= 3) {
      setState(() {
        _fieldsSec.removeRange(_fieldsSec.length - 3, _fieldsSec.length);
        _controllersSec.removeRange(
            _controllersSec.length - 3, _controllersSec.length);
      });
    }
  }

  // Function to add 3 text fields for Treasurer
  void _addThreeTextFieldsTre() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for Treasurer
  void _removeThreeTextFieldsTre() {
    if (_fieldsTre.length >= 3) {
      setState(() {
        _fieldsTre.removeRange(_fieldsTre.length - 3, _fieldsTre.length);
        _controllersTre.removeRange(
            _controllersTre.length - 3, _controllersTre.length);
      });
    }
  }

  // Function to add 3 text fields for Auditor
  void _addThreeTextFieldsAud() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for Auditor
  void _removeThreeTextFieldsAud() {
    if (_fieldsAud.length >= 3) {
      setState(() {
        _fieldsAud.removeRange(_fieldsAud.length - 3, _fieldsAud.length);
        _controllersAud.removeRange(
            _controllersAud.length - 3, _controllersAud.length);
      });
    }
  }

  // Function to add 3 text fields for Data Representative
  void _addThreeTextFieldsData() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for Data Representative
  void _removeThreeTextFieldsData() {
    if (_fieldsData.length >= 3) {
      setState(() {
        _fieldsData.removeRange(_fieldsData.length - 3, _fieldsData.length);
        _controllersData.removeRange(
            _controllersData.length - 3, _controllersData.length);
      });
    }
  }

  // Function to add 3 text fields for IT Representative
  void _addThreeTextFieldsITR() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for IT Representative
  void _removeThreeTextFieldsITR() {
    if (_fieldsITR.length >= 3) {
      setState(() {
        _fieldsITR.removeRange(_fieldsITR.length - 3, _fieldsITR.length);
        _controllersITR.removeRange(
            _controllersITR.length - 3, _controllersITR.length);
      });
    }
  }

  // Function to add 3 text fields for ISR
  void _addThreeTextFieldsISR() {
    for (int i = 0; i < 3; i++) {
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
  }

  // Function to remove the last 3 text fields for ISR
  void _removeThreeTextFieldsISR() {
    if (_fieldsISR.length >= 3) {
      setState(() {
        _fieldsISR.removeRange(_fieldsISR.length - 3, _fieldsISR.length);
        _controllersISR.removeRange(
            _controllersISR.length - 3, _controllersISR.length);
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
                      _addThreeTextFieldsPres();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsPres();
                    },
                    fields: _fieldsPres,
                  ),
                  CustomContainerWidget(
                    positionText: 'Vice President',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsVice();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsVice();
                    },
                    fields: _fieldsVice,
                  ),
                  CustomContainerWidget(
                    positionText: 'Secretary',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsSec();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsSec();
                    },
                    fields: _fieldsSec,
                  ),
                  CustomContainerWidget(
                    positionText: 'Treasurer',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsTre();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsTre();
                    },
                    fields: _fieldsTre,
                  ),
                  CustomContainerWidget(
                    positionText: 'Auditor',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsAud();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsAud();
                    },
                    fields: _fieldsAud,
                  ),
                  CustomContainerWidget(
                    positionText: 'Data Privacy',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsData();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsData();
                    },
                    fields: _fieldsData,
                  ),
                  CustomContainerWidget(
                    positionText: 'IT Representative',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsITR();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsITR();
                    },
                    fields: _fieldsITR,
                  ),
                  CustomContainerWidget(
                    positionText: 'IS Representative',
                    action1Text: 'Add Candidate',
                    action2Text: 'Remove Textfield',
                    onAction1Tap: () {
                      _addThreeTextFieldsISR();
                    },
                    onAction2Tap: () {
                      _removeThreeTextFieldsISR();
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
        ],
      ),
    );
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
              Text(
                positionText,
                style:
                    TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onAction1Tap,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[300]),
                        child: Text(
                          action1Text,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: onAction2Tap,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[300]),
                        child: Text(action2Text,
                            style: TextStyle(color: Colors.black)),
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
