import 'package:flutter/material.dart';

import 'main.dart';
 
class DonationsPage extends StatefulWidget {
  const DonationsPage({Key? key}) : super(key: key);
 
 
 
  @override
  _DonationsPageState createState() => _DonationsPageState();
}
 
class _DonationsPageState extends State<DonationsPage> {
  String userName = "Shaan Kalgaonkar"; // Replace with the actual user name
  String paymentInfo = "Payment: "; // Replace with user's payment info
  double donationAmount = 0.0; // Variable to store the donation amount
  String recipientInfo = ""; // Variable to store recipient's information
  List<String> receivedDonations = ["10 from Jeff Bezos", "25 from TheAnonymousHelper"]; // Replace with actual received donations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Donation Page"),
        backgroundColor: theme.backgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle), // User icon symbol
            onPressed: () {
              // Add code to handle the user icon click
              showUserInformation();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                showSendDonationsDialog();
              },
              child: Text("Send Donations"),
            ),
            ElevatedButton(
              onPressed: () {
                showReceivedDonations();
              },
              child: Text("Received Donations"),
            ),
          ],
        ),
      ),
    );
 }
 
  void showUserInformation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(userName),
          content: Text(paymentInfo),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
 
  void showSendDonationsDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController recipientController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Send Donations"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: "Donation Amount (\$)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: recipientController,
                decoration: InputDecoration(labelText: "Recipient's Information"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  donationAmount = double.tryParse(amountController.text) ?? 0.0;
                  recipientInfo = recipientController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Send"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
 
  void showReceivedDonations() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Received Donations"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: receivedDonations
                .map((donation) => ListTile(title: Text(donation)))
                .toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
   );
  }
}