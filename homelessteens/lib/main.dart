import 'package:flutter/material.dart';
import 'package:homelessteens/donationspage.dart';
import 'package:homelessteens/heartpage.dart';
import 'package:homelessteens/homepage.dart';
import 'package:homelessteens/resumepage.dart';
import 'package:homelessteens/util.dart';

final ThemeData theme = ThemeData(
  primaryColor: fromHexcode("#743F9D"),
  primaryColorLight: fromHexcode("#5757AD"),
  backgroundColor: fromHexcode("#E5D9F4"),
  canvasColor: fromHexcode("493b7a"),
  errorColor: Colors.red[300],
);
TextStyle REGULAR = TextStyle(
  color: Colors.white,

);
TextStyle REGULARBLACK = TextStyle(
  color: Colors.black,

);
TextStyle TITLE = TextStyle(
  color: Colors.white,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const MyHomePage(title: 'Teen Help 4 Life'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  bool accountPage = false;
  PageController d = PageController(initialPage: 1);
  bool showUserInfo = false;


  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
    
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showUserInfo = !showUserInfo;
                });
              },
              icon: Icon(Icons.person)
            ),
            Text("Good Afternoon, Arindam"),
          ],
        ),
      ),
      body: Center(
          child: showUserInfo
            ? UserInfoPage()          
            
            : Stack(
              children: [
                PageView(
                  physics: NeverScrollableScrollPhysics() ,
                  controller: d,
                  children: const <Widget> [
                    Heartpage(),
                    HomePage(),
                    Resumepage(),
                    DonationsPage()
                  ]
                )
              ],
            )
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.primaryColor,
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,size: 50),
          label: "Social"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map,size: 50),
          label: "Map"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.portrait,size: 50),
          label: "Resume"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_rounded,size: 50,),
          label: "Donations"
        ),
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          d.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
        });
      },
      currentIndex: _selectedIndex,
      ),
    );
  }
}
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