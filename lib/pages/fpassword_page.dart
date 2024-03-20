import 'package:flutter/material.dart';

class FpasswordPage extends StatelessWidget {
  const FpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 70, 192, 151),
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
                  child: const Center(
                    child: Icon(Icons.lock),
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
