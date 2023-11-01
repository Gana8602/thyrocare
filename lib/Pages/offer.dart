import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<String> image = [
    'assets/ban1.png',
    'assets/ban2.jpg',
    'assets/ban3.png',
    'assets/banner.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'My Offers',
            style: TextStyle(
                color: AC.TC, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image[i]), fit: BoxFit.cover)),
                ),
              )
          ],
        )
      ],
    ));
  }
}
