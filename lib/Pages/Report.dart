import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thyrocare/utils/colors.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                              Text(
                                name[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(gender[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(width: 10),
                                  Text(age[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(width: 10),
                                  Text(date[index],
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
