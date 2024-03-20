import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//import 'package:flutter_new/pages/signup_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeecfff),
      bottomNavigationBar: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter text..",
              suffixIcon: Icon(
                Icons.send,
              ))),
      // bottomSheet: TextField(decoration: InputDecoration(border:OutlineInputBorder() ,hintText: "enter text"),),
      appBar: AppBar(
        title: const Text("Chat",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: AutofillHints.birthdayYear)),
        centerTitle: true,
        backgroundColor: const Color(0xffbe74ff),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            child: const Text(
              "performing hot restart while running application",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 2,
        //           blurRadius: 5),
        //     ],
        //   ),
        //   child: CircleAvatar(radius: 40,),
        // ),
        Container(
          alignment: Alignment.topRight,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffbe74ff),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            child: const Text(
              "performing hot restart while running tgfgfgkyv application",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ),

        Container(
          alignment: Alignment.topRight,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffbe74ff),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            child: const Text(
              "performing hot restart ",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            child: const Text(
              "performing hot restart while running application.restarted application in components",
              style: TextStyle(fontSize: 15),
            ),
          ),
        )
      ]),
    );
  }
}
