import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thyrocare/utils/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String? patientID;
  @override
  void initState() {
    super.initState();
    GetLocalID().then((_) {
      if (patientID != null) {
        getReport();
      } else {
        print('PatientID is null');
      }
    });
  }

  Future<void> GetLocalID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve data from SharedPreferences
      patientID = prefs.getString('patientID');
      print('patientid = $patientID');
    });
  }

  List<dynamic> userInformation = [];
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
          var appDocDir = await getApplicationDocumentsDirectory();
          var file = File('${appDocDir.path}/$fileName');
          await file.writeAsBytes(response.bodyBytes);
          print('File downloaded successfully : $fileName as ${file.path}');
          await showNotification(fileName, file.path);
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

  Future<void> getReport() async {
    if (patientID == null || patientID!.isEmpty) {
      print('PatientID is empty or null');
      return;
    }

    final url =
        'http://ban58.thyroreport.com/api/Report/GetReportsByPatientID?PatientID=$patientID';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print("Received JSON Response: $jsonResponse");
        if (jsonResponse.isNotEmpty) {
          setState(() {
            userInformation = List<Map<String, dynamic>>.from(jsonResponse);
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userData', json.encode(jsonResponse));
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
        throw Exception('Failed to load reports data');
      }
    } catch (e) {
      print('Error fetching reports: $e');
      throw Exception('Failed to load reports data');
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
      'File: Path: $storedPath $fileName\nStored ',
      'File Downloaded',
      platformChannelSpecifics,
    );
  }

  // List<Map<String, String>> userInformation = [];
  List<String> name = [
    'vijay Srivatsava',
    'vijay Srivatsava',
    'vijay Srivatsava',
    'vijay Srivatsava',
    'vijay Srivatsava',
    'vijay Srivatsava'
  ];
  List<String> gender = [
    'M',
    'M',
    'M',
    'M',
    'M',
    'M',
  ];
  List<String> age = [
    '40 yrs',
    '40 yrs',
    '40 yrs',
    '40 yrs',
    '40 yrs',
    '40 yrs',
  ];
  List<String> date = [
    '25-11-2023',
    '20-03-2023',
    '19-06-2023',
    '18-07-2023',
    '17-08-2023',
    '16-09-2023',
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   // Call a function to fetch user data on initialization
  //   GetReport(context);
  // }

  // Future<void> GetReport(BuildContext context) async {
  //   final url =
  //       'http://ban58.thyroreport.com/api/Report/GetReportsByPatientID?PatientID=1';
  //   final response = await http.get(
  //     Uri.parse(url),
  //   );
  //   // Navigate to the next screen after successful verification
  //   if (response.statusCode == 200) {
  //     // Assuming the response is a JSON array as mentioned earlier
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     print("Received JSON Response: $jsonResponse");
  //     if (jsonResponse.isNotEmpty) {
  //       // User has an account, navigate to the Home screen
  //       setState(() {
  //         userInformation = jsonResponse;
  //       });
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString('userData', json.encode(jsonResponse));
  //       // Navigate based on user existence
  //     }
  //   } else {
  //     print('Request failed with status: ${response.statusCode}');
  //   }
  // }

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
                  color: AC.TC, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          userInformation.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: userInformation.length,
                    itemBuilder: (BuildContext context, int index) {
                      String firstName = userInformation[index]['firstName'] ??
                          'Name Not Available';
                      String lastName = userInformation[index]['lastName'] ??
                          'Name Not Available';
                      String genderName =
                          userInformation[index]['sex'] ?? 'Name Not Available';
                      String ageName =
                          userInformation[index]['age'].toString() ??
                              'Name Not Available';
                      String collectedDateString =
                          userInformation[index]['collectedOn'];
                      String datePortion = collectedDateString
                          .split('T')[0]; // Extracting only the date portion

                      String formattedDate = datePortion;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '$firstName $lastName',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(genderName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(width: 10),
                                        Text(ageName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(width: 10),
                                        Text(formattedDate,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  downloadFile(
                                      userInformation[index]['pdfReportName']);
                                  // Add functionality here
                                },
                                icon: const Icon(Icons.download_rounded),
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
