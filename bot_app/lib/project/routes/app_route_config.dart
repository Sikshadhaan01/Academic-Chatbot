import 'package:flutter/material.dart';
import 'package:flutter_new/main.dart';
import 'package:flutter_new/pages/announement_add_page.dart';
import 'package:flutter_new/pages/chat_page.dart';
import 'package:flutter_new/pages/home_page.dart';
import 'package:flutter_new/pages/login_page.dart';
import 'package:flutter_new/pages/notes_page.dart';
import 'package:flutter_new/pages/otp_page.dart';
import 'package:flutter_new/pages/signup_page.dart';
import 'package:flutter_new/pages/splash_screen.dart';
import 'package:flutter_new/pages/topics_page.dart';
import 'package:flutter_new/pages/fpassword_page.dart';
import 'package:flutter_new/project/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppRouter {
  MyAppRouter() {
    getIsLoggedIn();
  }
  bool isLoggedIn = false;
  getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString("userInfo");
    isLoggedIn = userInfo == null ? false : true;
  }

  GoRouter router = GoRouter(initialLocation: "/splash_screen", routes: [
    GoRoute(
      name: MyAppRouteConstant.login_pageRouteName,
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(child: LoginPage());
      },
    ),
    GoRoute(
      name: 'splash_screen',
      path: '/splash_screen',
      pageBuilder: (context, state) {
        return MaterialPage(child: SplashScreen());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.home_pageRouteName,
      path: '/home_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: HomePage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.signup_pageRouteName,
      path: '/signup_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: SignupPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.teacher_pageRouteName,
      path: '/announcement_add_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: AnnouncementAddPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.notes_pageRouteName,
      path: '/notes_page/:department/:semester/:subject',
      pageBuilder: (context, state) {
        return MaterialPage(
            child: NotesPage(
          department: state.pathParameters['department'],
          semester: state.pathParameters['semester'],
          subject: state.pathParameters['subject'],
        ));
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.topics_pageRouteName,
      path: '/topics_page/:department',
      pageBuilder: (context, state) {
        return MaterialPage(
            child: TopicsPage(
          department: state.pathParameters['department'],
        ));
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.chat_pageRouteName,
      path: '/chat_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: ChatPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.fpassword_pageRouteName,
      path: '/fpassword_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: FpasswordPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstant.otp_pageRouteName,
      path: '/otp_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: Otppage());
      },
    )
  ]);
}
