import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_radio_button.dart';

class SelectACountryScreen extends StatelessWidget {
  SelectACountryScreen({Key? key})
      : super(
          key: key,
        );

  String radioGroup = "";

  List<String> radioList = [
    "lbl_afghanistan",
    "lbl_albania",
    "lbl_algeria",
    "lbl_andorra",
    "lbl_angola",
    "msg_antigua_and_barbuda",
    "lbl_argentina",
    "lbl_argentina",
    "lbl_armenia",
    "lbl_australia",
    "lbl_austria",
    "lbl_azerbaijan",
    "lbl_azerbaijan"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildSelectACountry(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildSelectACountry(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 24.v,
            right: 217.h,
          ),
          child: CustomRadioButton(
            text: "Afghanistan",
            value: radioList[2],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 22.v,
            right: 253.h,
          ),
          child: CustomRadioButton(
            text: "Albania",
            value: radioList[3],
            groupValue: radioGroup,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 24.v,
            right: 256.h,
          ),
          child: CustomRadioButton(
            text: "Algeria\r",
            value: radioList[4],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 22.v,
            right: 248.h,
          ),
          child: CustomRadioButton(
            text: "Andorra",
            value: radioList[5],
            groupValue: radioGroup,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 24.v,
            right: 256.h,
          ),
          child: CustomRadioButton(
            text: "Angola",
            value: radioList[6],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 22.v,
            right: 148.h,
          ),
          child: CustomRadioButton(
            text: "Antigua and Barbuda\r",
            value: radioList[7],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 22.v,
            right: 234.h,
          ),
          child: CustomRadioButton(
            text: "Argentina",
            value: radioList[8],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 22.v,
            right: 234.h,
          ),
          child: CustomRadioButton(
            text: "Argentina",
            value: radioList[9],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 22.v,
            right: 246.h,
          ),
          child: CustomRadioButton(
            text: "Armenia",
            value: radioList[10],
            groupValue: radioGroup,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 24.v,
            right: 243.h,
          ),
          child: CustomRadioButton(
            text: "Australia",
            value: radioList[11],
            groupValue: radioGroup,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 24.v,
            right: 256.h,
          ),
          child: CustomRadioButton(
            text: "Austria",
            value: radioList[12],
            groupValue: radioGroup,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 24.v,
            right: 229.h,
          ),
          child: CustomRadioButton(
            text: "Azerbaijan",
            value: radioList[13],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24.h, 22.v, 229.h, 5.v),
          child: CustomRadioButton(
            text: "Azerbaijan",
            value: radioList[14],
            groupValue: radioGroup,
            onChange: (value) {
              radioGroup = value;
            },
          ),
        ),
      ],
    );
  }
}
