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
      body: Column(
      children: [
        DropdownMenu(
            dropdownMenuEntries: [
              DropdownMenuEntry(value: Text("Suicide Hotline: 988", style: REGULAR,), label: "Suicide Hotline: 988"),
              DropdownMenuEntry(value: Text("1-800-273-TALK", style: REGULAR,), label: "1-800-273-TALK"),
              DropdownMenuEntry(value: Text("police non emergency : 206-296-3111", style: REGULAR,), label: "police non emergency : 206-296-3111"),
              DropdownMenuEntry(value: Text("Sexual Assault resource center : 1-888-99-VOICE", style: REGULAR,), label: "Sexual Assault resource center : 1-888-99-VOICE"),
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
        TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Send a message',
            ),
            controller: textEditingController,
            onSubmitted: (String inputText) {
              setState(() {
                posts.add(
                  MediaPost(name: "hello", message: inputText)
                );
                textEditingController.clear();
              }); 
            }
        )
      ],
    ),
    );
  }
}
class MediaPost extends StatelessWidget {
MediaPost({ Key? key , required this.name, required this.message}) : super(key: key);

  String name = "";
  String message = "";

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor),
            borderRadius: BorderRadius.circular(50)
          ),
          child: Row(
            children: [
              Icon(Icons.person, color: Colors.white,),
              Text("${name}:", style: REGULAR),
              SizedBox(height: 20, width: 20,),
              Flexible(child: Text(message, style: REGULAR)),
            ],
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
