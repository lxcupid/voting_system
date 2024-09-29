import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb

class AdminElection extends StatefulWidget {
  const AdminElection({super.key});

  @override
  State<AdminElection> createState() => _AdminElectionState();
}

class _AdminElectionState extends State<AdminElection> {
  String? selectedItem = 'CCST'; // Default selected item
  final List<String> items = [
    'CCST',
    'COE',
    'COA',
    'CAS',
    'CTE',
    'CTHM',
    'CAHS',
    'CBA',
    'CHK'
  ];

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
  final TextEditingController _title = TextEditingController();

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

  void _addThreeTextFieldsPres() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerPres = TextEditingController();
      _controllersPres.add(_controllerPres);

      // Separate variables to store image data for web and desktop
      File? selectedImage;
      Uint8List? selectedWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsPres.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsPres.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerPres,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 != 0)
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedWebImage = result.files.first.bytes;

                                // Update the image without replacing the button
                                setStateImage(() {});
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedImage = File(result.files.single.path!);

                                // Update the image without replacing the button
                                setStateImage(() {});
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedWebImage != null)
                          Image.memory(
                            selectedWebImage!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedImage != null)
                          Image.file(
                            selectedImage!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  void _removeThreeTextFieldsPres() {
    if (_fieldsPres.length >= 2) {
      setState(() {
        _fieldsPres.removeRange(_fieldsPres.length - 2, _fieldsPres.length);
        _controllersPres.removeRange(
            _controllersPres.length - 2, _controllersPres.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each Vice candidate
  void _addThreeTextFieldsVice() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerVice = TextEditingController();
      _controllersVice.add(_controllerVice);

      // Separate variables to store image data for web and desktop
      File? selectedViceImage;
      Uint8List? selectedViceWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsVice.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsVice.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerVice,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 != 0) // Button and image picker only for 'Vice Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedViceWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedViceImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedViceWebImage != null)
                          Image.memory(
                            selectedViceWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedViceImage != null)
                          Image.file(
                            selectedViceImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Vice President
  void _removeThreeTextFieldsVice() {
    if (_fieldsVice.length >= 2) {
      setState(() {
        _fieldsVice.removeRange(_fieldsVice.length - 2, _fieldsVice.length);
        _controllersVice.removeRange(
            _controllersVice.length - 2, _controllersVice.length);
      });
    }
  }

// Function to add 2 text fields and an image picker button for each Secretary candidate
  void _addThreeTextFieldsSec() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerSec = TextEditingController();
      _controllersSec.add(_controllerSec);

      // Separate variables to store image data for web and desktop
      File? selectedSecImage;
      Uint8List? selectedSecWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsSec.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsSec.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerSec,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Secretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedSecWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedSecImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedSecWebImage != null)
                          Image.memory(
                            selectedSecWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedSecImage != null)
                          Image.file(
                            selectedSecImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Secretary
  void _removeThreeTextFieldsSec() {
    if (_fieldsSec.length >= 2) {
      setState(() {
        _fieldsSec.removeRange(_fieldsSec.length - 2, _fieldsSec.length);
        _controllersSec.removeRange(
            _controllersSec.length - 2, _controllersSec.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each Treretary candidate
  void _addThreeTextFieldsTre() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerTre = TextEditingController();
      _controllersTre.add(_controllerTre);

      // Separate variables to store image data for web and desktop
      File? selectedTreImage;
      Uint8List? selectedTreWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsTre.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsTre.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerTre,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Treretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedTreWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedTreImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedTreWebImage != null)
                          Image.memory(
                            selectedTreWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedTreImage != null)
                          Image.file(
                            selectedTreImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Treasurer
  void _removeThreeTextFieldsTre() {
    if (_fieldsTre.length >= 2) {
      setState(() {
        _fieldsTre.removeRange(_fieldsTre.length - 2, _fieldsTre.length);
        _controllersTre.removeRange(
            _controllersTre.length - 2, _controllersTre.length);
      });
    }
  }

// Function to add 2 text fields and an image picker button for each Audretary candidate
  void _addThreeTextFieldsAud() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerAud = TextEditingController();
      _controllersAud.add(_controllerAud);

      // Separate variables to store image data for web and desktop
      File? selectedAudImage;
      Uint8List? selectedAudWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsAud.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsAud.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerAud,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Audretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedAudWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedAudImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedAudWebImage != null)
                          Image.memory(
                            selectedAudWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedAudImage != null)
                          Image.file(
                            selectedAudImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Auditor
  void _removeThreeTextFieldsAud() {
    if (_fieldsAud.length >= 2) {
      setState(() {
        _fieldsAud.removeRange(_fieldsAud.length - 2, _fieldsAud.length);
        _controllersAud.removeRange(
            _controllersAud.length - 2, _controllersAud.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each Dataretary candidate
  void _addThreeTextFieldsData() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerData = TextEditingController();
      _controllersData.add(_controllerData);

      // Separate variables to store image data for web and desktop
      File? selectedDataImage;
      Uint8List? selectedDataWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsData.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsData.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerData,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'Dataretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedDataWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedDataImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedDataWebImage != null)
                          Image.memory(
                            selectedDataWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedDataImage != null)
                          Image.file(
                            selectedDataImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for Data Representative
  void _removeThreeTextFieldsData() {
    if (_fieldsData.length >= 2) {
      setState(() {
        _fieldsData.removeRange(_fieldsData.length - 2, _fieldsData.length);
        _controllersData.removeRange(
            _controllersData.length - 2, _controllersData.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each ITRretary candidate
  void _addThreeTextFieldsITR() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerITR = TextEditingController();
      _controllersITR.add(_controllerITR);

      // Separate variables to store image ITR for web and desktop
      File? selectedITRImage;
      Uint8List? selectedITRWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsITR.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsITR.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerITR,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'ITRretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedITRWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedITRImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedITRWebImage != null)
                          Image.memory(
                            selectedITRWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedITRImage != null)
                          Image.file(
                            selectedITRImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for IT Representative
  void _removeThreeTextFieldsITR() {
    if (_fieldsITR.length >= 2) {
      setState(() {
        _fieldsITR.removeRange(_fieldsITR.length - 2, _fieldsITR.length);
        _controllersITR.removeRange(
            _controllersITR.length - 2, _controllersITR.length);
      });
    }
  }

  // Function to add 2 text fields and an image picker button for each ISRretary candidate
  void _addThreeTextFieldsISR() {
    for (int i = 0; i < 2; i++) {
      TextEditingController _controllerISR = TextEditingController();
      _controllersISR.add(_controllerISR);

      // Separate variables to store image ISR for web and desktop
      File? selectedISRImage;
      Uint8List? selectedISRWebImage; // For web

      // Create a variable to track the index of the button/image pair
      int imageIndex = _fieldsISR.length;

      setState(() {
        String labelText = i % 2 == 0 ? 'Candidate ' : 'Motto ';

        _fieldsISR.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controllerISR,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                  ),
                ),
                if (i % 2 !=
                    0) // Button and image picker only for 'ISRretary Motto'
                  StatefulBuilder(builder: (context, setStateImage) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(7),
                            backgroundColor: Colors.green[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (kIsWeb) {
                              // Web: Select and handle image as Uint8List
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedISRWebImage = result.files.first.bytes;
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            } else {
                              // Desktop (Windows): Select and handle image as File
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (result != null) {
                                selectedISRImage =
                                    File(result.files.single.path!);
                                setStateImage(
                                    () {}); // Update state to display image
                              }
                            }
                          },
                          child: Text('Pick Candidate Image'),
                        ),
                        SizedBox(height: 10),
                        // Display the selected image or a placeholder
                        if (kIsWeb && selectedISRWebImage != null)
                          Image.memory(
                            selectedISRWebImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else if (!kIsWeb && selectedISRImage != null)
                          Image.file(
                            selectedISRImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Text('No image selected'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        );
      });
    }
  }

  // Function to remove the last 3 text fields for ISR
  void _removeThreeTextFieldsISR() {
    if (_fieldsISR.length >= 2) {
      setState(() {
        _fieldsISR.removeRange(_fieldsISR.length - 2, _fieldsISR.length);
        _controllersISR.removeRange(
            _controllersISR.length - 2, _controllersISR.length);
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 215, 215, 215),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<String>(
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _title,
                      decoration: InputDecoration(
                        labelText: 'Election Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     _imageBytes != null
                  //         ? Image.memory(_imageBytes!)
                  //         : Text('No image selected.'),
                  //     SizedBox(height: 20),
                  //     ElevatedButton(
                  //       onPressed: _pickImage,
                  //       child: Text('Pick Image from Web'),
                  //     ),
                  //   ],
                  // ),
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
