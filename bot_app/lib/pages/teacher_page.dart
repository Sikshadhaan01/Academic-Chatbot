import 'package:flutter/material.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("text"),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter..",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.send))))),
    );
  }
}
