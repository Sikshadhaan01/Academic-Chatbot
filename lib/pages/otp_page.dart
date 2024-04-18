import 'package:flutter/material.dart';
import 'package:flutter_new/components/my_textfields.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class Otppage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
   Otppage({super.key});

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
                key: formKey,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone_iphone),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'OTP Verification',
                            style: TextStyle(
                              color: Color(0xFF404969),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: MyTextfields(
                             controller: TextEditingController(),
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Enter valid Email";
                                  }
                                  return null;
                                },
                            labelText: "OTP",
                                obscureText: false,
                                inputIcon: const Icon(null),
                            // decoration: const InputDecoration(
                            //   border: OutlineInputBorder(),
                            //   labelText: 'OTP',
                            //   contentPadding: EdgeInsets.all(16),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: MyTextfields(
                             controller: TextEditingController(),
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Enter valid Email";
                                  }
                                  return null;
                                },
                            labelText: "Confirm Password",
                                obscureText: false,
                                inputIcon: const Icon(null),
                            // decoration: const InputDecoration(
                            //   border: OutlineInputBorder(),
                            //   labelText: 'New password',
                            //   contentPadding: EdgeInsets.all(16),
                            // ),
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    GoRouter.of(context).pushNamed(
                                        MyAppRouteConstant.home_pageRouteName);
                                  },
                                  child: const Text(
                                    'Change password',
                                    // style: TextStyle(fontSize: 16),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xffeecfff))),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
