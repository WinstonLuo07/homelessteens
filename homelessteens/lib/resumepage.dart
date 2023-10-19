import 'package:flutter/material.dart';

class Resumepage extends StatefulWidget {
  const Resumepage({ Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  _ResumepageState createState() => _ResumepageState();
}

class _ResumepageState extends State<Resumepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
    );
  }
}