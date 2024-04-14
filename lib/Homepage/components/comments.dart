import 'package:flutter/material.dart';
class Comment extends StatelessWidget{
  final String text;
  final String username;
  //final String time;
  const Comment({super.key, required this.text, required this.username, /*required this.time*/});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 33, 33),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //text
          Icon(Icons.comment),
          Text(text),
          //username,time
          Row(
            children: [
              Icon(Icons.person),
              Text(username),
              Text("."),
             // Text(time),
            ],)
        ],
       ),
    );
  }

}