import 'package:flutter/material.dart';

class DonationsPage extends StatefulWidget {
  const DonationsPage({ Key? key, required this.color }) : super(key: key);

  final Color color;
  @override
  _DonationsPageState createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
    );
  }
}