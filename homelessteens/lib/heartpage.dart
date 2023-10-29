import 'package:flutter/material.dart';
import 'package:homelessteens/main.dart';

class Heartpage extends StatefulWidget {
  const Heartpage({ Key? key}) : super(key: key);

  @override
  _HeartpageState createState() => _HeartpageState();
}

class _HeartpageState extends State<Heartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
    );
  }
}
