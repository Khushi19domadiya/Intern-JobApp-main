import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

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

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      // Replace 'HomeScreen()' with the screen you want to navigate to
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => OnboardingThreeScreen(),
      ));
    });
    super.initState();
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
                height:300.adaptSize,
                width: 300.adaptSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}