import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

import '../../../models/user_model.dart';

// ignore: must_be_immutable
class Fulltime7ItemWidget extends StatelessWidget {

  Fulltime7ItemWidget({
    Key? key,
    required this.model,
  }) : super(
      key: key
  );


  postjobModel model;

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
        "${model.jobType}",
        style: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.gray100,
      selectedColor: appTheme.gray100,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          8.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
