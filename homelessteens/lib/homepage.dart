import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
    );
  }
}