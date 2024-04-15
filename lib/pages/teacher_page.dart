import 'package:flutter/material.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("text"),
        backgroundColor: Color(0xffbe74ff),
      ),
      body: Center(
          child: FloatingActionButton.extended(
              onPressed: () {}, label: Text("Add"))),
    );
  }
}
