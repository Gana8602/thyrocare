import 'package:flutter/material.dart';

class Cashback extends StatefulWidget {
  const Cashback({super.key});

  @override
  State<Cashback> createState() => _CashbackState();
}

class _CashbackState extends State<Cashback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Cashback Page')),
    );
  }
}
