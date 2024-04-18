import 'package:flutter/material.dart';
import 'package:flutter_new/components/my_textfields.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class FpasswordPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  FpasswordPage({super.key});

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
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail,
                                size: 30.0,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Forgot Password",
                                style: TextStyle(
                                  color: Color(0xFF404969),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              MyTextfields( 
                                controller: TextEditingController(),
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Enter valid Email";
                                  }
                                  return null;
                                },
                                labelText: "Email",
                                obscureText: false,
                                inputIcon: const Icon(null),
                                
                                // decoration: InputDecoration(
                                //   labelText: "Email",

                                //   contentPadding: EdgeInsets.all(16),
                                //   border: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //       color: Color.fromARGB(255, 10, 7, 7),
                                //     ),
                                //     // borderRadius: BorderRadius.circular(8),
                                //   ),
                                //   // focusedBorder: const OutlineInputBorder(
                                //   //   borderSide: BorderSide(
                                //   //       color: Color.fromARGB(255, 5, 5, 5)),
                                //   // ),
                                // ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    GoRouter.of(context).pushNamed(
                                        MyAppRouteConstant.otp_pageRouteName);
                                  }
                                },
                                child: Text("Submit"),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xffeecfff))),
                              )
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
