import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'package:get/get.dart';

import 'servies/firebase_messing.dart';


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: theme,
          title: 'job_app',
          onInit: (){
            FirebaseNotificationService.initializeService();
          },
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

// this is chan