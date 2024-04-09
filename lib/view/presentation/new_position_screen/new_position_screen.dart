import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:job_app/widgets/app_bar/appbar_title.dart';
import 'package:job_app/widgets/app_bar/custom_app_bar.dart';
import 'package:job_app/widgets/custom_drop_down.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';
import 'package:job_app/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class NewPositionScreen extends StatelessWidget {
  NewPositionScreen({Key? key}) : super(key: key);

  TextEditingController frameOneController = TextEditingController();

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController nameController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController frameOneController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 36.v),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 24.h, right: 24.h, bottom: 5.v),
                              child: Column(children: [
                                _buildInputField1(context),
                                SizedBox(height: 20.v),
                                _buildInputField2(context),
                                SizedBox(height: 20.v),
                                _buildInputField3(context),
                                SizedBox(height: 18.v),
                                _buildInputField4(context),
                                SizedBox(height: 18.v),
                                _buildInputField5(context),
                                SizedBox(height: 18.v),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("End Date",
                                        style: theme.textTheme.titleSmall)),
                                SizedBox(height: 9.v),
                                _buildInputField6(context,
                                    labelText: "Select Date"),
                                SizedBox(height: 20.v),
                                _buildInputField8(context)
                              ]))))
                ])),
            bottomNavigationBar: _buildSaveChanges(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapArrowBack(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Add New Position"));
  }

  /// Section Widget
  Widget _buildInputField1(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Title", style: theme.textTheme.titleSmall),
      SizedBox(height: 9.v),
      CustomTextFormField(
          controller: frameOneController, hintText: "Ex: UI Designer")
    ]);
  }

  /// Section Widget
  Widget _buildInputField2(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Employment Type", style: theme.textTheme.titleSmall),
          SizedBox(height: 7.v),
          CustomDropDown(
              icon: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 14.v, 19.h, 13.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgCheckmarkGray900,
                      height: 24.adaptSize,
                      width: 24.adaptSize)),
              hintText: "Please Select",
              items: dropdownItemList,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildInputField3(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Company Name", style: theme.textTheme.titleSmall),
      SizedBox(height: 7.v),
      CustomTextFormField(controller: nameController, hintText: "Ex: Shopee")
    ]);
  }

  /// Section Widget
  Widget _buildInputField4(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Location ", style: theme.textTheme.titleSmall),
      SizedBox(height: 9.v),
      CustomTextFormField(
          controller: locationController, hintText: "Ex: Singapore, Singapore")
    ]);
  }

  /// Section Widget
  Widget _buildInputField5(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Start Date", style: theme.textTheme.titleSmall),
      SizedBox(height: 9.v),
      _buildInputField6(context, labelText: "Select Date")
    ]);
  }

  /// Section Widget
  Widget _buildInputField8(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Job Role Description", style: theme.textTheme.titleSmall),
      SizedBox(height: 7.v),
      CustomTextFormField(
          controller: frameOneController1,
          hintText: "Lorem ipsun",
          textInputAction: TextInputAction.done,
          maxLines: 6,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v))
    ]);
  }

  /// Section Widget
  Widget _buildSaveChanges(BuildContext context) {
    return CustomElevatedButton(
        text: "Save Changes",
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 37.v),
        onPressed: () {
          onTapSaveChanges(context);
        });
  }

  /// Common widget
  Widget _buildInputField6(
    BuildContext context, {
    required String labelText,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 13.v),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder24),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Text(labelText,
                  style: CustomTextStyles.titleMediumBluegray400
                      .copyWith(color: appTheme.blueGray400))),
          CustomImageView(
              imagePath: ImageConstant.imgCalendar,
              height: 24.adaptSize,
              width: 24.adaptSize)
        ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the experienceSettingScreen when the action is triggered.
  onTapSaveChanges(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.experienceSettingScreen);
  }
}
