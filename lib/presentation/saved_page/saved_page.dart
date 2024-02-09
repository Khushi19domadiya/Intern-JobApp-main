import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/controller/jobController.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/saved_page/widgets/saved_item_widget.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import '../../models/user_model.dart';
import '../apply_job_screen/apply_job_screen.dart';
import '../filter_bottomsheet/filter_bottomsheet.dart';
import '../job_details_page/applyer_list_screen.dart';
import '../job_details_page/job_applyer_screen.dart';

class SavedPage extends StatefulWidget {
  SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  jobController controller = Get.put(jobController());
  String? userRole;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Get the current user's ID from Firebase Authentication

    fetchUserRole();
  }

  void fetchUserRole() async {
    var userDoc =
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
    setState(() {
      userRole = userDoc['role'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.only(left: 24.h, top: 30.v, right: 24.h),
          child: FutureBuilder<List<PostJobModel>>(
            future: controller.fetchJobDataFromFirestore(userRole.toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print("-----------has data---------");
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.v);
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    PostJobModel model = snapshot.data[index];
                    return SavedItemWidget(
                      onTapBag: () {
                        // onTapBag(context);

                        if(userRole == "e") {
                          Get.to(() => ApplyerListScreen());
                        }else{
                          Get.to(() => ApplyJobScreen(jobId: model.id,));

                        }

                      },
                      model: model,
                    );
                  },
                );
              } else {
                print("--------- else  ---------");
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
        onTap: () {
          onTapImage(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Jobs"),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilter,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
          onTap: () {
            showFilterBottomSheet(context); // Call the filter bottom sheet
          },
        ),
      ],
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterBottomsheet();
      },
    );
  }

  // void onTapBag(BuildContext context) {
  //   // Navigator.pushNamed(context, AppRoutes.jobDetailsTabContainerScreen);
  //
  //
  // }

  void onTapImage(BuildContext context) {
    Navigator.pop(context);
  }
}
