import 'package:flutter/material.dart';
import 'package:flutter_new/services/bot_service.dart';
// import 'package:flutter/rendering.dart';
//import 'package:flutter_new/pages/signup_page.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  List queriesAndAnswers = [];

  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: TextField(
              controller: queryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ask...",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      sendQuery();
                    },
                    child: Icon(
                      Icons.send,
                    ),
                  ))),
        ),
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
        body: queriesAndAnswers.isNotEmpty
            ? SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                reverse: true,
                physics: ClampingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: queriesAndAnswers.map((e) {
                      return Align(
                        alignment: e['answer'] == null
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: e['answer'] != null
                                  ? const Color(0xffbe74ff)
                                  : Color.fromARGB(255, 216, 178, 250),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e['answer'] != null
                                  ? e['answer']
                                  : e['query']),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              )
            : Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 100,
                          height: 100,
                          child: Image(
                              colorBlendMode: BlendMode.darken,
                              image: AssetImage('assets/chat-bot.gif'))),
                      Text(
                        "Start asking...",
                        style:
                            TextStyle(color: Color.fromARGB(255, 179, 95, 253)),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  sendQuery() async {
    var value = {"query": queryController.text};
    setState(() {
      queriesAndAnswers.add(value);
    });
    var response = await BotService().sendQuery(value);
    setState(() {
      queriesAndAnswers.add(response);
    });
    scrollToEnd();
    queryController.clear();
  }

  scrollToEnd() {
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
