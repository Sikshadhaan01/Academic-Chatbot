import 'package:flutter/material.dart';
import 'package:flutter_new/pages/login_page.dart';
import 'package:flutter_new/project/routes/app_route_config.dart';
// import 'package:go_router/go_router.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, 
     routerConfig: MyAppRouter().router,
      // home: LoginPage(),
//
    );
  }
}
