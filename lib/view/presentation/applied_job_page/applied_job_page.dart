import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';

class AppliedJobPage extends StatefulWidget {
  const AppliedJobPage({Key? key}) : super(key: key);

  @override
  AppliedJobPageState createState() => AppliedJobPageState();
}

class AppliedJobPageState extends State<AppliedJobPage>
    with AutomaticKeepAliveClientMixin<AppliedJobPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildAppliedSection(context)));
  }

  /// Section Widget
  Widget _buildAppliedSection(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 419.v),
            child: Column(children: [
              SizedBox(height: 20.v),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Job Description",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 13.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nec porttitor magna luctus tortor. Pretium malesuada lobortis consequat et mauris. \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nec porttitor magna luctus tortor. Pretium malesuada lobortis consequat et mauris. \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nec porttitor magna luctus tortor. Pretium malesuada lobortis consequat et mauris. ",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 28.v),
                    decoration: AppDecoration.linear,
                    child: Column(children: [
                      SizedBox(height: 12.v),
                      CustomElevatedButton(
                          text: "Applied",
                          buttonStyle: CustomButtonStyles.fillGrayTL24,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumGray50001)
                    ]))
              ])
            ])));
  }
}
