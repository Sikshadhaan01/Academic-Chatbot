import 'package:flutter/material.dart';
import 'package:flutter_new/components/my_textfields.dart';
// import 'package:flutter_new/pages/home_page.dart';
// import 'package:flutter_new/pages/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:flutter_new/services/common_service.dart';
import 'package:flutter_new/services/user_service.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var child;

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final usernamecontroller = TextEditingController();

  final confirmpasswordcontroller = TextEditingController();

  String dropdownValue = 'student';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 192, 151),
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
                const SizedBox(
                  height: 200,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Create your account",
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 30),
                MyTextfields(
                  controller: usernamecontroller,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Enter Valid Name";
                    }
                    return null;
                  },
                  labelText: "Username",
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
                const SizedBox(
                  height: 15,
                ),
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
                    Icons.key,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                 MyTextfields(
                  controller: confirmpasswordcontroller,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Confirm Password";
                    }
                    return null;
                  },
                  labelText: "Confirm Password",
                  obscureText: true,
                  inputIcon: const Icon(
                    Icons.key,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signUp();
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
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                          context
                              .goNamed(MyAppRouteConstant.login_pageRouteName);
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
        ),
      ),
    );
  }

  signUp() async {

     var password = passwordcontroller.text;
     var confirmPassword = confirmpasswordcontroller.text;

     if(password != confirmPassword){
      // show error msg //
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password do not match')));
      return;
     }

    var obj = {
      "userName": usernamecontroller.text,
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
      "confirmPassword":confirmpasswordcontroller.text
      
    };
    var response = await UserService().signup(obj);
    bool success = CommonService().handleResponseMessage(context, response);
    if (success) {
      GoRouter.of(context).pushNamed(MyAppRouteConstant.home_pageRouteName);
    }
  }
}
