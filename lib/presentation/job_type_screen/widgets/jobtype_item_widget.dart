import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

import '../../../controller/authController.dart';

class JobtypeItemWidget extends StatefulWidget {
  final Function(String) onJobTypeSelected;

  const JobtypeItemWidget({Key? key, required this.onJobTypeSelected}) : super(key: key);

  @override
  _JobtypeItemWidgetState createState() => _JobtypeItemWidgetState();
}

class _JobtypeItemWidgetState extends State<JobtypeItemWidget> {
  String selectedJobType = '';
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildJobTypeContainer(
          imagePath: ImageConstant.imgWork,
          title: "Find a job",
          description: "It’s easy to find your dream jobs here with us.",
          jobType: "j",
        ),
        SizedBox(width: 10.h), // Add spacing between containers
        _buildJobTypeContainer(
          imagePath: ImageConstant.imgWork,
          title: "Find an employee",
          description: "It's easy to find an employee.",
          jobType: "e",
        ),
      ],
    );
  }

  Widget _buildJobTypeContainer({
    required String imagePath,
    required String title,
    required String description,
    required String jobType,
  }) {
    return InkWell(
      onTap: () async {
        setState(() {
          selectedJobType = jobType;
        });

        // Notify the parent about the selected job type
        widget.onJobTypeSelected(selectedJobType);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 17.h,
          vertical: 20.v,
        ),
        decoration: AppDecoration.outlinePrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
          border: Border.all(
            color: selectedJobType == jobType
                ? theme.colorScheme.primary
                : Colors.transparent,
          ),
        ),
        width: 156.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.v),
            CustomIconButton(
              height: 54.adaptSize,
              width: 64.adaptSize,
              padding: EdgeInsets.all(16.h),
              decoration: IconButtonStyleHelper.fillGrayTL16,
              child: CustomImageView(
                imagePath: imagePath,
              ),
            ),
            SizedBox(height: 29.v),
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 9.v),
            SizedBox(
              width: 120.h,
              child: Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.labelLargeGray500_1.copyWith(
                  height: 1.67,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
