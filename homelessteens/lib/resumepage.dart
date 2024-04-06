import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

import 'main.dart';
 
class Resumepage extends StatefulWidget {
  const Resumepage({Key? key}) : super(key: key);

 
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
    return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/resume_scaffold.png"),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
          Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: resumeTips.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(color: Colors.white, Icons.lightbulb),
                          title: Text(resumeTips[index], style: TextStyle(color: Colors.white)),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
          Align(
            child: Column(
              children: [
                SizedBox(
                  height:400
                ),
                ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(
                              250, 70
                            )
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: theme.primaryColorLight)
                            )
                          )
                        ),
                        onPressed: () {
                          
                        },
                        child: Text("Resume Templates"),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(
                              250, 70
                            )
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: theme.primaryColorLight)
                            )
                          )
                        ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                              Text("Resume mailed to Jobs!"),
                              backgroundColor: theme.primaryColor,
                              ),
                    );
                  },
                  child: Text("Submit Resume"),
                ),
              ],
            ),
          ),
        ],
    );
  }
}