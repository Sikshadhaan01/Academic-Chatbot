import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_new/pages/login_page.dart';
import 'package:flutter_new/project/routes/app_route_config.dart';
import 'package:flutter_new/providers/announcement_provider.dart';
import 'package:flutter_new/providers/subject_provider.dart';
import 'package:flutter_new/providers/user_provider.dart';
import 'package:flutter_new/services/download_helper.dart';
import 'package:provider/provider.dart';

// import 'package:go_router/go_router.dart';
void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true);
  }
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SubjectProvider())),
        ChangeNotifierProvider(create: ((context) => UserProvider())),
         ChangeNotifierProvider(create: ((context) => AnnouncementProvider())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRouter().router,
        // home: LoginPage(),
        //
      ),
    );
  }
}
