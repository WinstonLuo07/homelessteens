import 'package:flutter/material.dart';
import 'package:homelessteens/main.dart';

class Heartpage extends StatefulWidget {
  const Heartpage({ Key? key}) : super(key: key);

  @override
  _HeartpageState createState() => _HeartpageState();
}

class _HeartpageState extends State<Heartpage> {

  List<MediaPost> posts = <MediaPost> [
                  MediaPost(
                  name: "Shaan Kalgonkar", message: "Hey, how's everybody doing? Anybody need a place tonight?",
                  ),
                  MediaPost(
                  name: "John Michaelson", message: "Life sucks right now... I would really appreciate it",
                  ),
                  MediaPost(
                  name: "Frederick Dingleberry", message: "Dont worry my friend. Everything is going to be okay.",
                  ),
                  MediaPost(
                  name: "John Michaelson", message: "Thanks Frederick, lets meet up.",
                  ),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/heart_scaffold.png"),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
          Column(
          children: [
            DropdownMenu(
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: Text("Suicide Hotline: 988", style: REGULARBLACK,), label: "Suicide Hotline: 988"),
                  DropdownMenuEntry(value: Text("1-800-273-TALK", style: REGULARBLACK,), label: "1-800-273-TALK"),
                  DropdownMenuEntry(value: Text("police non emergency : 206-296-3111", style: REGULARBLACK,), label: "police non emergency : 206-296-3111"),
                  DropdownMenuEntry(value: Text("Sexual Assault resource center : 1-888-99-VOICE", style: REGULARBLACK,), label: "Sexual Assault resource center : 1-888-99-VOICE"),
                ],
                onSelected: (value) {
                  setState(() {
                    
                  });
                },
            ),
            SizedBox(
              height: 500,
              child: ListView(
                children: posts
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                        expands: false,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          hintText: 'Send a message',
                        ),
                        controller: textEditingController,
                        onSubmitted: (String inputText) {
                          
                          if (inputText == "") {
                            // print("NAOFNAOF");
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                            //   Text("Please enter in a message"),
                            //   backgroundColor: theme.errorColor,
                            //   ),
                            //   );
                            return;
                          }
                          setState(() {
                            posts.add(
                              MediaPost(name: "Arindam Sanyal", message: inputText)
                            );
                            textEditingController.clear();
                          }); 
                        }
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (textEditingController.text == "") {
                            // print("NAOFNAOF");
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
                            //   Text("Please enter in a message"),
                            //   backgroundColor: theme.errorColor,
                            //   ),
                            //   );
                            return;
                          }
                      setState(() {
                          posts.add(
                            MediaPost(name: "hello", message: textEditingController.text)
                          );
                          textEditingController.clear();
                      });
                    }, 
                  icon: Icon(Icons.send))
                ],
              ),
            )
          ],
    ),
        ],
      ),
    );
  }
}
class MediaPost extends StatelessWidget {
MediaPost({ Key? key , required this.name, required this.message}) : super(key: key);

  String name = "";
  String message = "";
  
  final Map<String,Color> pfpIDs = {
    "Shaan Kalgonkar": Colors.blue[100]!,
    "John Michaelson": Colors.green[100]!,
    "Frederick Dingleberry": Colors.pink[100]!
  };

  @override
  Widget build(BuildContext context){

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 325
            ),
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("${name} * ${TimeOfDay.now().hourOfPeriod}:${TimeOfDay.now().minute} ${TimeOfDay.now().hour <= 12 ? "AM" : "PM"}", 
                    style: TextStyle(
                      color: Colors.black
                    )),
                  ],
                ),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: pfpIDs[name],
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(90),
                        // border: Border.all(color: pfpIDs[name]!)
                      ),
                      child: Icon(Icons.person, color: Colors.white, size: 50)),
                    SizedBox(height: 20, width: 20,),
                    Flexible(
                      child: Text(message, 
                      style: TextStyle(
                      color: Colors.black
                    )),)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
