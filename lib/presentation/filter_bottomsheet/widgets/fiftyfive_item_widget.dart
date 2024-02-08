import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

class FiftyfiveItemWidget extends StatefulWidget {
  const FiftyfiveItemWidget({Key? key}) : super(key: key);

  @override
  _FiftyfiveItemWidgetState createState() => _FiftyfiveItemWidgetState();
}

class _FiftyfiveItemWidgetState extends State<FiftyfiveItemWidget> {
  List<bool> isSelectedList = [false, false, false]; // List to track selection state

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5), // Add space between categories
        _buildChip("Front End", 0), // Pass index 0 for Front End
        SizedBox(height: 5), // Add space between categories
        _buildChip("Back End", 1), // Pass index 1 for Back End
        SizedBox(height: 5), // Add space between categories
        _buildChip("Database", 2), // Pass index 2 for Database
      ],
    );
  }

  Widget _buildChip(String labelText, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical padding as needed
      child: RawChip(
        padding: EdgeInsets.only(
          top: 14.v,
          right: 10.h,
          bottom: 14.v,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          labelText,
          style: TextStyle(
            color: isSelectedList[index] ? Colors.white : Colors.black,
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
        selected: isSelectedList[index],
        backgroundColor: isSelectedList[index] ? appTheme.deepOrangeA200 : Colors.white,
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
            isSelectedList = [false, false, false]; // Deselect all categories
            isSelectedList[index] = value; // Select the clicked category
          });
        },
      ),
    );
  }
}
