import 'package:get/get.dart';
import 'package:saumil_s_application/controller/jobController.dart';

import '../../models/user_model.dart';
import '../saved_page/widgets/saved_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';

class SavedPage extends StatelessWidget {
  SavedPage({Key? key}) : super(key: key);

  jobController controller = Get.put(jobController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Padding(
                padding: EdgeInsets.only(left: 24.h, top: 30.v, right: 24.h),
                child: FutureBuilder<List<postjobModel>>(
                  future: controller.fetchJobDataFromFirestore(),
                  builder: (context, AsyncSnapshot snapshot) {

                      if(snapshot.hasData){
                        print("-----------has data---------");
                        return ListView.separated(

                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12.v);
                            },
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              postjobModel model = snapshot.data[index];
                              return SavedItemWidget(onTapBag: () {
                                onTapBag(context);
                              }, model: model,);
                            });
                    }
                    else {
                        print("--------- else  ---------");
                      return const Center(child:  CircularProgressIndicator());
                    }
                  }
                ),
            ),
        ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapImage(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Saved"),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgComponent3,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        ]);
  }

  /// Navigates to the jobDetailsTabContainerScreen when the action is triggered.
  onTapBag(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.jobDetailsTabContainerScreen);
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }
}
