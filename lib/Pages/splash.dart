import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thyrocare/Pages/Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigate to the register page after 3 seconds
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegistrationPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image taking 70% of the screen
          Positioned.fill(
            child: Image.asset(
              'assets/logo.jpg', // Replace with your image asset
              fit: BoxFit.contain,
            ),
          ),
          // "Developed by" text content at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 80, // Adjust bottom position as needed
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'Powered By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 49, 88),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50, // Adjust bottom position as needed
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'NVS Arogya, Thyrocare Sarjapur',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 49, 88),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
