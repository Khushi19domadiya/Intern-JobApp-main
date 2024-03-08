import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_outlined_button.dart';

import '../../controller/authController.dart';

class LogoutPopupDialog extends StatelessWidget {
   LogoutPopupDialog({Key? key}) : super(key: key);

  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: _buildPopUp(context),
      ),
    );
  }

  Widget _buildPopUp(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
      height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
      child: Container(
        padding: EdgeInsets.all(20.0), // Adjust padding as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgProfileOnprimary,
              height: 82.adaptSize,
              width: 82.adaptSize,
            ),
            SizedBox(height: 20.0), // Adjust vertical spacing as needed
            Text("Are You Sure?", style: CustomTextStyles.titleMediumBold),
            SizedBox(height: 10.0), // Adjust vertical spacing as needed
            Container(
              width: 200.0, // Adjust width as needed
              margin: EdgeInsets.symmetric(horizontal: 10.0), // Adjust horizontal margin as needed
              child: Text(
                "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleSmallBluegray400SemiBold
                    .copyWith(height: 1.57),
              ),
            ),
            SizedBox(height: 20.0), // Adjust vertical spacing as needed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    height: 46.0, // Adjust height as needed
                    text: "Log Out",
                    onPressed: () {
                      Get.find<AuthController>().signOut(); // Call the signOut method from AuthController
                    },

                  ),
                ),

                SizedBox(width: 10.0), // Adjust horizontal spacing between buttons as needed
                Expanded(
                  child: CustomElevatedButton(
                    height: 46.0, // Adjust height as needed
                    text: "Cancel",
                    onPressed: () {
                      onTapCancel(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  static void onTapLogOut(BuildContext context) {
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   AppRoutes.signUpCreateAcountScreen,
    //       (route) => false,
    // );
  }

  /// Navigates to the settingsScreen when the action is triggered.
  static void onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }
}
