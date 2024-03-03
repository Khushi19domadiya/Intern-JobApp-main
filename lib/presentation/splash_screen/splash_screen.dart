import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/controller/authController.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/servies/firebase_messing.dart';

import '../home_container_screen/home_container_screen.dart';
import '../onboarding_three_screen/onboarding_three_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var controller = Get.put(AuthController());
  @override
  void initState() {
    init();
    super.initState();
    FirebaseNotificationService.getNotification();
  }

  Future init() async {
    Timer(Duration(seconds: 3), () async {
      // Replace 'HomeScreen()' with the screen you want to navigate to

      var isLogin = await controller.isUserSignedIn();
      if (isLogin) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeContainerScreen(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OnboardingThreeScreen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgClarityEmployeeSolid,
                height: 102.adaptSize,
                width: 102.adaptSize,
              ),
              SizedBox(height: 24.v),
              Text(
                "Hired",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
