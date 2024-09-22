import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context,
    {required VoidCallback onConfirm,
    required String title,
    required String message}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.green, // Set the dialog background to green
        title: Text(title,
            style: const TextStyle(
                color: Colors.white)), // White text for the title
        content: Text(message,
            style: const TextStyle(
                color: Colors.white)), // White text for the message
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green[300]!), // Button background color
              foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.black), // Button text color
            ),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm(); // Call the passed function
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green[300]!), // Button background color
              foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.black), // Button text color
            ),
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
