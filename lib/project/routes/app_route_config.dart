import 'package:flutter/material.dart';
import 'package:flutter_new/pages/chat_page.dart';
import 'package:flutter_new/pages/home_page.dart';
import 'package:flutter_new/pages/login_page.dart';
import 'package:flutter_new/pages/signup_page.dart';
import 'package:flutter_new/pages/teacher_page.dart';
import 'package:flutter_new/pages/topics_page.dart';
import 'package:flutter_new/pages/fpassword_page.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter{
GoRouter router=GoRouter(
  routes: [
    GoRoute(
      name:MyAppRouteConstant.login_pageRouteName,
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(child:LoginPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.home_pageRouteName,
      path: '/home_page',
      pageBuilder: (context, state) {
        return MaterialPage(child:HomePage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.signup_pageRouteName,
      path: '/signup_page',
      pageBuilder: (context, state) {
        return MaterialPage(child:SignupPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.teacher_pageRouteName,
      path: '/teacher_page',
      pageBuilder: (context, state) {
        return MaterialPage(child:TeacherPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.topics_pageRouteName,
      path: '/topics_page',
      pageBuilder: (context, state) {
        return MaterialPage(child:TopicsPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.chat_pageRouteName,
      path: '/chat_page',
      pageBuilder: (context, state) {
        return MaterialPage(child:ChatPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.fpassword_pageRouteName,
      path: '/fpassword_page',
      pageBuilder: (context, state) {
        return MaterialPage(child:FpasswordPage());
      },
    )
  ]
);
}