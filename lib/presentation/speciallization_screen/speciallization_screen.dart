import '../speciallization_screen/widgets/specialization_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/presentation/confirmation_dialog/confirmation_dialog.dart';

class SpeciallizationScreen extends StatelessWidget {
 final String selectedRole;
  const SpeciallizationScreen({Key? key,required this.selectedRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 31.v),
                child: Column(children: [
                  SizedBox(
                      width: 177.h,
                      child: Text("What is your specialization?",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall!
                              .copyWith(height: 1.33))),
                  SizedBox(height: 7.v),
                  Text("Lorem ipsum dolor sit amet, consectetur",
                      style: CustomTextStyles.titleSmallBluegray400),
                  SizedBox(height: 31.v),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildSpecialization(context),
                      ],
                    ),
                  )
                ])),
            bottomNavigationBar: _buildContinue(context,selectedRole)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapImage(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgComponent3,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildSpecialization(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.v);
            },
            itemCount: 6,
            itemBuilder: (context, index) {
              return SpecializationItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildContinue(BuildContext context,String selectedRole) {
    return CustomElevatedButton(
        text: "Continue",
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 39.v),
        onPressed: () {
          onTapContinue(context,selectedRole);
        });
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  /// Displays a dialog with the [ConfirmationDialog] content.
  onTapContinue(BuildContext context,String selectedRole) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: ConfirmationDialog(selectedRole:selectedRole ,),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }
}
