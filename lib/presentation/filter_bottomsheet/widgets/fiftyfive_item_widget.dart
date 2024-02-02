import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

class FiftyfiveItemWidget extends StatefulWidget {
  const FiftyfiveItemWidget({Key? key}) : super(key: key);

  @override
  _FiftyfiveItemWidgetState createState() => _FiftyfiveItemWidgetState();
}

class _FiftyfiveItemWidgetState extends State<FiftyfiveItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.only(
        top: 14.v,
        right: 10.h,
        bottom: 14.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Design & Creative",
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black, // Change text color here
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
        ),
      ),
      avatar: CustomImageView(
        imagePath: ImageConstant.imgCheckmarkOnprimarycontainer,
        height: 18.adaptSize,
        width: 18.adaptSize,
        margin: EdgeInsets.only(right: 5.h),
      ),
      selected: isSelected,
      backgroundColor: isSelected ? appTheme.deepOrangeA200 : Colors.white,
      selectedColor: appTheme.deepOrangeA200,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray300,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          22.h,
        ),
      ),
      onSelected: (value) {
        setState(() {
          isSelected = value;
        });
      },
    );
  }
}
