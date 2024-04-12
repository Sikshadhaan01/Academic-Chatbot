import 'package:flutter/material.dart';
import 'package:flutter_new/components/my_textfields.dart';
import 'package:flutter_new/pages/home_page.dart';
import 'package:flutter_new/pages/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var child;

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final usernamecontroller = TextEditingController();

  final confirmpasswordcontroller = TextEditingController();

  // List<String> items = ["item1", "item2"];

  // String? selecteditem = "item1";

  String dropdownValue = 'student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 192, 151),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/rm222-mind-20.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 169, 19, 210),
                  fontFamily: AutofillHints.birthdayYear),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Create your account",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 169, 19, 210)),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfields(
              controller: usernamecontroller,
              hintText: "Username",
              obscureText: false,
              inputIcon: const Icon(
                Icons.person,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextfields(
              controller: emailcontroller,
              hintText: "Email",
              obscureText: false,
              inputIcon: const Icon(
                Icons.email,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextfields(
              controller: passwordcontroller,
              hintText: "Password",
              obscureText: true,
              inputIcon: const Icon(
                Icons.key,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextfields(
              controller: confirmpasswordcontroller,
              hintText: "Confirm Password",
              obscureText: true,
              inputIcon: const Icon(
                Icons.key,
                size: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              itemHeight: null,
              //underline: null,
              value: dropdownValue,
              items: <String>['student', 'teacher']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
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
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 30),
            Text.rich(TextSpan(children: [
              const TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                    color: Color.fromARGB(255, 15, 11, 11),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 5,
              )),
              TextSpan(
                  text: "Login",
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      GoRouter.of(context).pushNamed(MyAppRouteConstant.login_pageRouteName);
                      // context.goNamed(MyAppRouteConstant.login_pageRouteName);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => LoginPage(),
                      //   ),
                      // );
                    })
            ]))
          ],
        ),
      ),
    );
  }
}
