import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:flutter_new/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogged();
  }
  checkLogged()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    // var userInfo = jsonDecode(prefs.getString('userInfo'));
    if(prefs.getString('userInfo') != null){
      Provider.of<UserProvider>(context, listen: false).setUserInfo(jsonDecode(prefs.getString('userInfo')!));
      GoRouter.of(context).pushNamed(MyAppRouteConstant.home_pageRouteName);
    }else{
      GoRouter.of(context).pushNamed(MyAppRouteConstant.login_pageRouteName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
  }
}