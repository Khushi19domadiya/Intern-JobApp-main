import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

// ignore: must_be_immutable
class Fulltime1ItemWidget extends StatelessWidget {
  const Fulltime1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 6.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Fulltime",
        style: TextStyle(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(0.64),
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.indigo900,
      selectedColor: appTheme.indigo900,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          14.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
