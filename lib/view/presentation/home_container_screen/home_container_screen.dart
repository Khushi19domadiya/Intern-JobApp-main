import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/view/presentation/home_page/home_page.dart';
import 'package:job_app/view/presentation/message_page/message_page.dart';
import 'package:job_app/view/presentation/profile_page/profile_page.dart';
import 'package:job_app/view/presentation/saved_page/saved_page.dart';
import 'package:job_app/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatefulWidget {
  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}
RxInt currentIndex = 0.obs;
class _HomeContainerScreenState extends State<HomeContainerScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: currentIndex.stream,
          builder: (context, snapshot) {
            return _getCurrentPage(currentIndex.value);
          }
        ),
        bottomNavigationBar: StreamBuilder(
          stream: currentIndex.stream,
          builder: (context, snapshot) {
            return _buildBottomBar(context);
          }
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      selectIndex: currentIndex.value,
      onChanged: (BottomBarEnum type) {
        _updateCurrentPage(type);
      },
    );
  }

  /// Handling page based on index
  Widget _getCurrentPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return MessagePage();
      case 2:
        return SavedPage();
      case 3:
        return ProfilePage();
      default:
        return DefaultWidget();
    }
  }

  /// Handling page index based on bottom bar click actions
  void _updateCurrentPage(BottomBarEnum type) {

      switch (type) {
        case BottomBarEnum.Home:
          currentIndex.value = 0;
          break;
        case BottomBarEnum.Message:
          currentIndex.value = 1;
          break;
        case BottomBarEnum.Saved:
          currentIndex.value = 2;
          break;
        case BottomBarEnum.Profile:
          currentIndex.value = 3;
          break;
        default:
          currentIndex.value = 0;
      }
  }
}
