import 'package:flutter/material.dart';

class Heartpage extends StatefulWidget {
  const Heartpage({ Key? key , required this.color}) : super(key: key);

  final Color color;
  @override
  _HeartpageState createState() => _HeartpageState();
}

class _HeartpageState extends State<Heartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
    );
  }
}
