import 'widgets/notificationsgeneral_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

class NotificationsGeneralPage extends StatefulWidget {
  const NotificationsGeneralPage({Key? key}) : super(key: key);

  @override
  NotificationsGeneralPageState createState() =>
      NotificationsGeneralPageState();
}

class NotificationsGeneralPageState extends State<NotificationsGeneralPage>
    with AutomaticKeepAliveClientMixin<NotificationsGeneralPage> {
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
                  _buildNotificationsGeneral(context)
                ]))));
  }

  /// Section Widget
  Widget _buildNotificationsGeneral(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.5.v),
                  child: SizedBox(
                      width: 323.h,
                      child: Divider(
                          height: 1.v,
                          thickness: 1.v,
                          color: appTheme.gray300)));
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return NotificationsgeneralItemWidget();
            }));
  }
}
