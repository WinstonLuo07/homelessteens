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

  double wallet = 20.23;

  List<String> receivedDonations = ["\$10.20 from Jeff Bezos", "\$10.03 from TheAnonymousHelper"]; // Replace with actual received donations
  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      // appBar: AppBar(
      //   // title: Text("Donation Page"),
      //   backgroundColor: theme.backgroundColor,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.account_circle), // User icon symbol
      //       onPressed: () {
      //         // Add code to handle the user icon click
      //         showUserInformation();
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/donation_page.png"),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: theme.primaryColorLight, borderRadius: BorderRadius.circular(10)),
                    child: Text("\$ $wallet", style: TextStyle(fontSize: 80, color: Colors.white),),
                  ),
                ),
                const SizedBox(
                  height: 220
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 75),
                    backgroundColor: theme.primaryColor
                  ),
                  onPressed: () {
                    showSendDonationsDialog();
                  },
                  child: Text("Send Donation"),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 75),
                    backgroundColor: theme.primaryColor
                  ),
                  onPressed: () {
                    showReceivedDonations();
                  },
                  child: Text("Received Donations"),
                ),
              ],
            ),
          ),
        ],
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
                decoration: InputDecoration(labelText: "Recipient's Username"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  donationAmount = double.tryParse(amountController.text) ?? 0.0;
                  recipientInfo = recipientController.text;

                  if (wallet - donationAmount >= 0) {
                    wallet -= donationAmount;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                      Text("\$$donationAmount sent to $recipientInfo"),
                      backgroundColor: theme.primaryColor,
                      ),
                      );
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                      Text("Insufficient funds"),
                      backgroundColor: theme.errorColor,
                      ),
                      );
                  }
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