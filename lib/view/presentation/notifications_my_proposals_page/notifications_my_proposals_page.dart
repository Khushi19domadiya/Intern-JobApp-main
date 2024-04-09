import 'widgets/notificationsmyproposals_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

class NotificationsMyProposalsPage extends StatefulWidget {
  const NotificationsMyProposalsPage({Key? key}) : super(key: key);

  @override
  NotificationsMyProposalsPageState createState() =>
      NotificationsMyProposalsPageState();
}

class NotificationsMyProposalsPageState
    extends State<NotificationsMyProposalsPage>
    with AutomaticKeepAliveClientMixin<NotificationsMyProposalsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.background,
                child: Column(children: [
                  SizedBox(height: 24.v),
                  _buildOpenedSection(context)
                ]))));
  }

  /// Section Widget
  Widget _buildOpenedSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(top: 4.v),
                child: Text("Application Status (3)",
                    style: CustomTextStyles.titleMediumBold_1)),
            CustomImageView(
                imagePath: ImageConstant.imgArrowUp,
                height: 24.adaptSize,
                width: 24.adaptSize)
          ]),
          SizedBox(height: 23.v),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.5.v),
                    child: SizedBox(
                        width: 327.h,
                        child: Divider(
                            height: 1.v,
                            thickness: 1.v,
                            color: appTheme.gray300)));
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return NotificationsmyproposalsItemWidget();
              })
        ]));
  }
}
