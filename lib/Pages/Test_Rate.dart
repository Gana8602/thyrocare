import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TestRate extends StatefulWidget {
  const TestRate({super.key});

  @override
  State<TestRate> createState() => _TestRateState();
}

class _TestRateState extends State<TestRate> {
  List<String> testName = [
    'AAROGYAM C PRO',
    'HB',
    'HBA1C',
    'KIDNEY PROFILE',
    'DIABETIC PROFILE',
    'LIVER PROFILE',
  ];
  List<String> price = [
    '2599',
    '400',
    '325',
    '899',
    '100',
    '600',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Test details',
              style: TextStyle(
                  color: AC.TC, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Column(
            children: [
              for (int i = 0; i < 6; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(testName[i]),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(price[i]),
                          )
                        ],
                      )),
                )
            ],
          )
        ],
      ),
    );
  }
}
