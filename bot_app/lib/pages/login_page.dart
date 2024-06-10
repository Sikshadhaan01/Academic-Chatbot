import 'dart:convert';
// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/components/my_textfields.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:flutter_new/providers/user_provider.dart';
import 'package:flutter_new/services/common_service.dart';
import 'package:flutter_new/services/user_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 250),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
                SizedBox(height: 30),
                //email
                MyTextfields(
                  controller: emailcontroller,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Enter Valid Email";
                    }
                    return null;
                  },
                  labelText: "Email",
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
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Enter Valid Password";
                    }
                    return null;
                  },
                  labelText: "Password",
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

                // Padding(
                //   padding: const EdgeInsets.only(right: 30),
                //   child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: GestureDetector(
                //       onTap: () {
                //         GoRouter.of(context).pushNamed(
                //             MyAppRouteConstant.fpassword_pageRouteName);
                //       },
                //       child: const Text(
                //         "Forgot Password?",
                //         style: TextStyle(
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black),
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 30),

                // MyButton(
                //   onTap: signUserIn,
                // )
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 250,
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
                        color: Colors.black,
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
                          GoRouter.of(context).pushNamed(
                              MyAppRouteConstant.signup_pageRouteName);
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
      ),
    );
  }

  login() async {
    var obj = {
      "email": emailcontroller.text,
      "password": passwordcontroller.text
    };
    var response = await UserService().login(obj);
    bool success = CommonService().handleResponseMessage(context, response);
    Provider.of<UserProvider>(context, listen: false)
        .setUserInfo(response['result'][0]);
    if (success) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("userInfo", json.encode(response['result'][0]));
        GoRouter.of(context).pushNamed(MyAppRouteConstant.home_pageRouteName);
      });
    }
  }
}
