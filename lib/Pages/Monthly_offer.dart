import 'package:flutter/material.dart';

class MonthlyOffer extends StatefulWidget {
  const MonthlyOffer({super.key});

  @override
  State<MonthlyOffer> createState() => _MonthlyOfferState();
}

class _MonthlyOfferState extends State<MonthlyOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monthly Offers',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/banner.png'), fit: BoxFit.cover)),
        ),
      )),
    );
  }
}
