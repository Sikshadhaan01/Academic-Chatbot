import 'package:flutter/material.dart';

class FpasswordPage extends StatelessWidget {
  const FpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeecfff),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffeecfff),
        ),
        child: Stack(
          children: [
            Center(
              child: Form(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 95, 95, 95),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            blurStyle: BlurStyle.outer), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail,
                            size: 40.0,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 10, 7, 7),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 5, 5, 5)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text("Submit"),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffeecfff))))
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
