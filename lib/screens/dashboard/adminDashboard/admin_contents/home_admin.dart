import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html; // Import for web file handling
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_model.dart';
import 'package:voting_system/screens/dashboard/adminDashboard/admin_contents/admin_candidate_widgets.dart';
import 'dart:io';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  List<AdminCandidate1> allCandidates = []; // List to hold all candidates
  List<AdminCandidate1> filteredCandidates = []; // List for filtered candidates
  String searchQuery = '';
  bool isLoading = true; // To manage loading state
  String apiUrl =
      'http://localhost:8005/user/candidates/votes'; // Update with your API endpoint

  @override
  void initState() {
    super.initState();
    _fetchCandidates();
  }

  Future<void> _fetchCandidates() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          allCandidates = jsonData
              .map((json) => AdminCandidate1.fromJson(json))
              .toList(); // Store all candidates
          filteredCandidates = List.from(
              allCandidates); // Initialize filteredCandidates with all candidates
          isLoading = false; // Set loading to false after fetching
        });
      } else {
        throw Exception('Failed to load candidates');
      }
    } catch (e) {
      print(e); // Handle errors
      setState(() {
        isLoading = false; // Set loading to false on error
      });
    }
  }

  void _filterCandidates(String query) {
    setState(() {
      searchQuery = query;
      // Filter based on the original list of candidates
      filteredCandidates = allCandidates
          .where((candidate) =>
              candidate.fullname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _exportToExcel(BuildContext context) async {
    final Dio dio = Dio();
    try {
      // API endpoint URL for exporting the candidates
      String url = 'http://localhost:8005/user/excel';

      // Show a downloading dialog or progress indicator
      print("Showing dialog...");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Downloading Excel file..."),
              ],
            ),
          );
        },
      );

      // Make the GET request to get the file data
      print("Starting download...");
      Response response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      print("Download complete, status code: ${response.statusCode}");

      // Close the progress dialog
      print("Closing dialog...");
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        if (kIsWeb) {
          // For web, create a blob and download it
          final blob = html.Blob([
            response.data
          ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
          final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: downloadUrl)
            ..setAttribute('download', 'candidates.xlsx')
            ..click();
          html.Url.revokeObjectUrl(downloadUrl); // Clean up after download

          // Inform the user of a successful download
          print("Download successful for web.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Excel file downloaded successfully.")),
          );
        } else {
          // For desktop (Windows, macOS, Linux), save the file locally
          String filePath = '';

          // Get the directory based on the platform
          if (io.Platform.isWindows ||
              io.Platform.isLinux ||
              io.Platform.isMacOS) {
            // Use the desktop's Downloads folder or a suitable directory
            filePath =
                '${(await getDownloadsDirectory())!.path}/candidates.xlsx';
          } else {
            // Fallback for other platforms if needed
            filePath =
                '${(await getTemporaryDirectory()).path}/candidates.xlsx';
          }

          // Save the file to the local file system
          final file = io.File(filePath);
          await file.writeAsBytes(response.data);

          // Inform the user of a successful download
          print("Download successful for desktop. File saved at: $filePath");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Excel file downloaded successfully: $filePath")),
          );
        }
      } else {
        print("Failed to download file, status code: ${response.statusCode}");
        throw Exception("Failed to download file");
      }
    } catch (e) {
      print("Error occurred: $e");
      // Close the progress dialog in case of an error
      Navigator.of(context).pop();
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to download file: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search candidates...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: _filterCandidates,
                  ),
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.green),
                  onPressed: () async {
                    await _exportToExcel(
                        context); // Use async/await to handle the Future
                  },
                  tooltip: 'Export to Excel',
                ),
              ],
            ),
          ),
          // Loading Indicator
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (filteredCandidates.isEmpty)
            const Center(child: Text('No candidates found.'))
          else
            // Candidate Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 400,
                ),
                itemCount: filteredCandidates.length,
                itemBuilder: (context, index) {
                  return AdminCandidateWidget(
                    candidate: filteredCandidates[index],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
