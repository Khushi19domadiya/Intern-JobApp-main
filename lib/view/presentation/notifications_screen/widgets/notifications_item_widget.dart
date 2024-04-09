import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_switch.dart';

// ignore: must_be_immutable
class NotificationsItemWidget extends StatelessWidget {
  NotificationsItemWidget({Key? key})
      : super(
          key: key,
        );

  bool isSelectedSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 2.v),
          child: Text(
            "New Post",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        CustomSwitch(
          value: isSelectedSwitch,
          onChange: (value) {
            isSelectedSwitch = value;
          },
        ),
      ],
    );
  }
}
