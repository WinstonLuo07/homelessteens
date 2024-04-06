import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Add functionality to edit user information
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Arindam Sanyal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'asanyal@gmail.com',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                '123-456-7890',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                'Sammamish, Washington',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'About Me',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'I am 17 years old, Junior in High School. I have recently been kicked out of my home due to family issues, couch surfing for the past few months',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 20),
            // Add more user information sections as needed
          ],
        ),
      ),
    );
  }
}