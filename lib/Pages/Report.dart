import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:thyrocare/main.dart';
import 'package:thyrocare/utils/colors.dart';
import 'package:android_intent/android_intent.dart';

class Report extends StatefulWidget {
  const Report({Key? key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<Map<String, dynamic>> userInformation = [];
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!_dataLoaded) {
      getReports();
    }
  }

  Future<void> getReports() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? patientID = prefs.getString('patientID');
      if (patientID != null) {
        final reports = await fetchReports(patientID);
        setState(() {
          userInformation = List<Map<String, dynamic>>.from(reports);
        });
      } else {
        print('PatientID is null');
      }
    } catch (e) {
      print('Error fetching reports: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchReports(String patientID) async {
    final url =
        'http://ban58.thyroreport.com/api/Report/GetReportsByPatientID?PatientID=$patientID';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        userInformation = List<Map<String, dynamic>>.from(jsonResponse);
        _dataLoaded = true; // Move this line here
      });
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load reports data');
    }
  }

  String convertGender(String gender) {
    if (gender == 'Male      ') {
      return 'M';
    } else if (gender == 'Female    ') {
      return 'F';
    }
    return 'Other'; // You can return an empty string or other handling for different cases
  }

  Future<void> downloadFile(String fileName) async {
    var url =
        'http://ban58files.thyroreport.com/UploadedFiles/Reports/$fileName';

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      if (status.isGranted) {
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var appDocDir = await getExternalStorageDirectory();
          var pdfFile = File('${appDocDir!.path}/$fileName');
          await pdfFile.writeAsBytes(response.bodyBytes);
          print('File downloaded successfully: $fileName as ${pdfFile.path}');
          await showNotification(fileName, pdfFile.path);
        } else {
          throw Exception('Failed to download file: ${response.statusCode}');
        }
      } else {
        throw Exception('Permission denied');
      }
    } catch (e) {
      print('Download error: $e');
      throw Exception('Failed to download file');
    }
  }

  Future<void> showNotification(String fileName, String storedPath) async {
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      importance: Importance.max,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'File downloaded',
      '$fileName downloaded successfully',
      platformChannelSpecifics,
    );

    // Intent to open the PDF file
    AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      type: 'application/pdf',
      data: storedPath,
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'My Reports',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          userInformation.isEmpty
              ? const Center(
                  child: Text('No Data Available'),
                )
              : Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: userInformation.length,
                    itemBuilder: (BuildContext context, int index) {
                      final firstName = userInformation[index]['firstName'] ??
                          'Name Not Available';
                      final lastName = userInformation[index]['lastName'] ??
                          'Name Not Available';
                      final gender =
                          userInformation[index]['sex'] ?? 'Name Not Available';
                      final ageName =
                          userInformation[index]['age'].toString() ??
                              'Name Not Available';
                      final collectedDateString =
                          userInformation[index]['collectedOn'];
                      final datePortion = collectedDateString
                          .split('T')[0]; // Extracting only the date portion
                      final TestName = userInformation[index]['testName'] ?? '';

                      final formattedDate = datePortion;
                      print("Gender Value: $gender");
                      final genderName = convertGender(gender);
                      print("Gender Name: $genderName");

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          decoration: const BoxDecoration(
                            gradient: AC.grBG,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '$firstName ',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          TestName,
                                          style: const TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '($genderName /',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '$ageName)',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  downloadFile(
                                      userInformation[index]['pdfReportName']);
                                  // Add functionality here
                                },
                                icon: const Icon(
                                  Icons.download_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
