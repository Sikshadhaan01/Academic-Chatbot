import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/components/my_textfields.dart';
import 'package:flutter_new/pages/fpassword_page.dart';
import 'package:flutter_new/pages/home_page.dart';
import 'package:flutter_new/pages/signup_page.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // void signUserIn(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:  Colors.black,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/rm222-mind-20.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),

              //login
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 185, 44, 224),
                    fontFamily: AutofillHints.birthdayYear),
              ),

              const SizedBox(height: 50),

              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(left: 25),
              //       child: Text(
              //         "Email",
              //         style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),

              //email
              MyTextfields(
                controller: emailcontroller,
                hintText: "Email",
                obscureText: false,
                inputIcon: const Icon(
                  Icons.email,
                  size: 20,
                ),
              ),

              const SizedBox(height: 30),

              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 25),
              //       child: Text(
              //         "Password",
              //         style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),

              //password
              MyTextfields(
                controller: passwordcontroller,
                hintText: "Password",
                obscureText: true,
                inputIcon: const Icon(
                  Icons.lock,
                  size: 20,
                ),
              ),

              const SizedBox(
                height: 5,
              ),
              //forgot password

              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Align(
                  alignment: Alignment.bottomRight,
                  
                  child: GestureDetector(
                    onTap:(){
                             GoRouter.of(context).pushNamed(MyAppRouteConstant.fpassword_pageRouteName);
              },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // MyButton(
              //   onTap: signUserIn,
              // )
              GestureDetector(
                 onTap:(){
                             GoRouter.of(context).pushNamed(MyAppRouteConstant.home_pageRouteName);
              },
                
            
                          
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 345,
                  height: 55,
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
               ),
              const SizedBox(height: 30),

              Text.rich(TextSpan(children: [
                const TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 5,
                )),
                TextSpan(
                    text: "SignUp",
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        GoRouter.of(context).pushNamed(MyAppRouteConstant.signup_pageRouteName);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const SignupPage(),
                        //   ),
                        // );
                      })
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
