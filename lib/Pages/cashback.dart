import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cashback extends StatefulWidget {
  const Cashback({Key? key});

  @override
  State<Cashback> createState() => _CashbackState();
}

class _CashbackState extends State<Cashback> {
  String? patientID;
  List<Map<String, dynamic>> cashbackData = [];

  @override
  void initState() {
    super.initState();
    GetLocalTest().then((_) {
      if (patientID != null) {
        retrieveCashbackData();
      } else {
        print('PatientID is null');
      }
    });
  }

  Future<void> GetLocalTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve data from SharedPreferences
      patientID = prefs.getString('patientID');
      print('patientid = $patientID');
    });
  }

  Future<List<Map<String, dynamic>>?> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://ban58.thyroreport.com/api/Cashback/GetCashbackByPatientID?PatientID=$patientID'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to load cashback data');
    }
  }

  Future<void> retrieveCashbackData() async {
    try {
      List<Map<String, dynamic>>? data = await fetchData();
      if (data != null) {
        setState(() {
          cashbackData = data;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'My Cashback',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          (cashbackData.isNotEmpty)
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Amount')),
                      ],
                      rows: cashbackData.map((item) {
                        DateTime? date =
                            DateTime.tryParse(item['createdDate'] ?? '');
                        String formattedDate =
                            date != null ? DateFormat.yMd().format(date) : '';
                        return DataRow(cells: [
                          DataCell(Text(formattedDate)),
                          DataCell(Text(item['isExpired'] ?? '')),
                          DataCell(Text(item['cashbackAmt']?.toString() ?? '')),
                        ]);
                      }).toList(),
                    ),
                  ),
                )
              : Text('no cashback found')
        ],
      ),
    );
  }
}
