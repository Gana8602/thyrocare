import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Cashback extends StatefulWidget {
  const Cashback({super.key});

  @override
  State<Cashback> createState() => _CashbackState();
}

class _CashbackState extends State<Cashback> {
  final List<Map<String, String>> reportData = [
    {
      'Date': '12/12/2002',
      'Status': 'Available',
      'Amount': '100',
    },
    {
      'Date': '12/12/2002',
      'Status': 'Expaired',
      'Amount': '100',
    },
    {
      'Date': '12/12/2002',
      'Status': 'Expaired',
      'Amount': '100',
    },
    {
      'Date': '12/12/2002',
      'Status': 'Expaired',
      'Amount': '100 ++',
    },
    {
      'Date': '12/12/2002',
      'Status': 'Expaired',
      'Amount': '100',
    },
    // Add more data as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'My Cashback',
            style: TextStyle(
                color: AC.TC, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0), // Optional rounded border
          ),
          child: SingleChildScrollView(
            child: DataTable(
              // headingRowColor: Colors.blue,
              columns: const <DataColumn>[
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Amount')),
              ],
              rows: List<DataRow>.generate(
                reportData.length,
                (index) => DataRow(cells: [
                  DataCell(Text(reportData[index]['Date'] ?? '')),
                  DataCell(Text(reportData[index]['Status'] ?? '')),
                  DataCell(Text(reportData[index]['Amount'] ?? '')),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
