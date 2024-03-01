import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

class FortysevenItemWidget extends StatelessWidget {
  const FortysevenItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Design & Creative",
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      selectedColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray300,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          22.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
