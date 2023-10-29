import 'package:flutter/material.dart';
import 'dart:math';
 
class Resumepage extends StatefulWidget {
  const Resumepage({Key? key, required this.color}) : super(key: key);
 
  final Color color;
 
  @override
  _ResumepageState createState() => _ResumepageState();
}
 
class _ResumepageState extends State<Resumepage> {
  final List<String> resumeTips = [
    "Highlight your key skills and achievements.",
    "Tailor your resume for each job application.",
    "Use action verbs to describe your accomplishments.",
    "Include relevant keywords for the job you're applying for.",
    "Keep your resume concise and easy to read.",
    // Add more tips as needed
  ];
 
  final Color buttonColor = Color(0xFF060839); // Hex color: #060839
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
       
        backgroundColor: widget.color,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: resumeTips.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.lightbulb),
                  title: Text(resumeTips[index]),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Add code to navigate to your resume guides page
                },
                child: Text("Resume Guides"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Add code to navigate to the resume submission page
                },
                child: Text("Submit Resume"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}