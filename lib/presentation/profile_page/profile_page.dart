import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/presentation/personal_info_screen/personal_info_screen.dart';
import 'package:saumil_s_application/presentation/profile_page/widgets/fortyseven_item_widget.dart';
import 'package:saumil_s_application/presentation/profile_page/widgets/profile_item_widget.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

import '../experience_setting_screen/AddSkillsScreen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
    this.onTapBag,
    this.model,
  }) : super(key: key);

  final VoidCallback? onTapBag;
  final UserModel? model;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userId;
  String? userRole;
  // late jobController controller;

  @override
  void initState() {
    super.initState();
    // Get the current user's ID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    // controller = jobController(); // Initialize the controller
    getClientStream();
    fetchUserRole();
  }

  RxList<PostJobModel> pOPJobs = <PostJobModel>[].obs;

  fetchUserRole() async {
    var userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(() {
      userRole = userDoc['role'];
    });
    // pOPJobs.value = await controller.fetchUserPostedJobs(userId);
    // pOPJobs.sort((a, b) => a.applyCount.compareTo(b.name));
  }

  getClientStream() async {
    var currentTime = Timestamp.now();
    var data = await FirebaseFirestore.instance.collection('postJob').orderBy('title').get();

    // Filter out records with a deadline that has already passed or equals the current date
    var validData = data.docs.where((doc) {
      var deadline = doc['deadline'] as Timestamp;
      return deadline.toDate().isAfter(DateTime.now());
    }).toList();

    // Update the state with validData
    setState(() {
      // Update the state variable
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30.v),
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildBackground(context),
                  SizedBox(height: 16.v),
                  Divider(color: appTheme.gray300),
                  SizedBox(height: 22.v),
                  _buildAboutMe(context),
                  SizedBox(height: 24.v),
                  // Conditionally show the skills list based on user role
                  if (userRole != 'e') _buildSkillsList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      // leading: AppbarLeadingImage(
      //   imagePath: ImageConstant.imgComponent1,
      //   margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
      //   onTap: () {
      //     onTapImage(context);
      //   },
      // ),
      centerTitle: true,
      title: AppbarTitle(text: "Profile"),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgComponent3Primary,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
          onTap: () {
            onTapImage1(context);
          },
        ),
      ],
    );
  }

  Widget _buildBackground(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc(
          FirebaseAuth.instance.currentUser?.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        UserModel userData = UserModel.fromMap(snapshot.data?.data() ?? {});
        String firstName = userData.fname ?? 'Anonymous';
        String lastName = userData.lname ?? '';
        String displayName = '$firstName $lastName';

        if (FirebaseAuth.instance.currentUser == null) {
          // User is not logged in, display a message
          return Center(
            child: Text(
              'User is not logged in.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        if (userData.profileUrl != null) {
          // User is logged in and has a profile URL
          String photoUrl = userData.profileUrl ?? "";
          return SizedBox(
            height: 225.v,
            width: 327.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70.h, // Increase the radius for a larger photo
                  backgroundImage: NetworkImage(photoUrl),
                ),
                SizedBox(height: 9.v),
                Text(
                  displayName,
                  style: CustomTextStyles.titleMediumBlack900,
                ),
                SizedBox(height: 7.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "Open to work",
                        style: CustomTextStyles.titleSmallGray500SemiBold_1,
                      ),
                    ),
                    Container(
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(left: 10.h, bottom: 3.v),
                      padding: EdgeInsets.all(3.h),
                      decoration: AppDecoration.success.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgCheck,
                        height: 9.adaptSize,
                        width: 9.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // Placeholder widget or nothing if photoUrl is null
          return SizedBox(
            height: 225.v,
            width: 327.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display full name without truncation
                Text(
                  displayName,
                  style: CustomTextStyles.titleMediumBlack900,
                ),
                SizedBox(height: 7.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "Open to work",
                        style: CustomTextStyles.titleSmallGray500SemiBold_1,
                      ),
                    ),
                    Container(
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(left: 10.h, bottom: 3.v),
                      padding: EdgeInsets.all(3.h),
                      decoration: AppDecoration.success.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgCheck,
                        height: 9.adaptSize,
                        width: 9.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }



  // Widget _buildJobApplied(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 24.h),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           child: Container(
  //             padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 12.v),
  //             decoration: AppDecoration.fillGray.copyWith(
  //               borderRadius: BorderRadiusStyle.roundedBorder24,
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 2.v),
  //                   child: Text(
  //                     "25",
  //                     style: CustomTextStyles.titleMediumBold_1,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 5.v),
  //                   child: Text(
  //                     "Applied",
  //                     style: theme.textTheme.labelLarge,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: CustomElevatedButton(
  //             height: 48.v,
  //             text: "10",
  //             margin: EdgeInsets.only(left: 19.h),
  //             buttonStyle: CustomButtonStyles.fillGrayTL241,
  //             buttonTextStyle: CustomTextStyles.titleMediumBold_1,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildAboutMe(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          UserModel userData = UserModel.fromMap(snapshot.data?.data() ?? {});

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.v),
              _buildSkills(
                context,
                skillsText: "About Me",
                onTapEditSquare: () {
                  onTapEditAbout(context);
                },
              ),

              SizedBox(height: 14.v),
              Container(
                width: 272.h,
                margin: EdgeInsets.only(right: 22.h),
                child: Text(
                  userData.about ?? "", // Use the 'aboutMe' field from 'userData'
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleSmallBluegray400.copyWith(height: 1.57),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _buildSkillsList(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder widget while data is loading
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Display error if any
        }
        UserModel userDeta = UserModel.fromMap(snapshot.data?.data() ?? {});
        List<String>? skillsData = userDeta.skills;
        List<String> skills =
            skillsData?.map((e) => e.toString()).toList() ?? []; // Cast to List<String>

        return Container(
          // width: 310, // Set the desired width here
          padding: EdgeInsets.all(15.h),
          margin: EdgeInsets.all(16.h),
          decoration: AppDecoration.outlineGray.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSkills(
                context,
                skillsText: "Skills",
                onTapEditSquare: () {
                  onTapEditSquare(context);
                },
              ),
              SizedBox(height: 15.v),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 11.5.v),
                    child: SizedBox(
                      width: 295.h,
                      child: Divider(
                        height: 1.v,
                        thickness: 1.v,
                        color: appTheme.gray300,
                      ),
                    ),
                  );
                },
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  // Display each skill fetched from Firestore
                  return Text(
                    skills[index],
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkills(BuildContext context, {
    required String skillsText,
    Function? onTapEditSquare,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            skillsText,
            style: CustomTextStyles.titleMediumBold_1.copyWith(
                color: theme.colorScheme.primary),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapEditSquare?.call();
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgEditSquarePrimary,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
      ],
    );
  }


  // Widget _buildExperience1(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 24.h),
  //     padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 14.v),
  //     decoration: AppDecoration.outlineGray.copyWith(
  //       borderRadius: BorderRadiusStyle.circleBorder12,
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _buildSkills(
  //           context,
  //           skillsText: "Experience",
  //           // editSquareImage: ImageConstant.imgEditSquarePrimary,
  //         ),
  //         SizedBox(height: 22.v),
  //         ListView.separated(
  //           physics: NeverScrollableScrollPhysics(),
  //           shrinkWrap: true,
  //           separatorBuilder: (context, index) {
  //             return Padding(
  //               padding: EdgeInsets.symmetric(vertical: 11.5.v),
  //               child: SizedBox(
  //                 width: 235.h,
  //                 child: Divider(
  //                   height: 1.v,
  //                   thickness: 1.v,
  //                   color: appTheme.gray300,
  //                 ),
  //               ),
  //             );
  //           },
  //           itemCount: 3,
  //           itemBuilder: (context, index) {
  //             return ProfileItemWidget();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildEducation1(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 24.h),
  //     padding: EdgeInsets.all(15.h),
  //     decoration: AppDecoration.outlineGray.copyWith(
  //       borderRadius: BorderRadiusStyle.circleBorder12,
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildSkills(
  //           context,
  //           skillsText: "Education",
  //           // editSquareImage: ImageConstant.imgEditSquarePrimary,
  //         ),
  //         SizedBox(height: 24.v),
  //         Padding(
  //           padding: EdgeInsets.only(right: 83.h),
  //           child: Row(
  //             children: [
  //               CustomIconButton(
  //                 height: 48.adaptSize,
  //                 width: 48.adaptSize,
  //                 padding: EdgeInsets.all(8.h),
  //                 child: CustomImageView(
  //                   imagePath: ImageConstant.imgFrame162724,
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: EdgeInsets.only(left: 12.h, top: 5.v),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "University of Oxford",
  //                         style: CustomTextStyles.titleSmallSemiBold,
  //                       ),
  //                       SizedBox(height: 6.v),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Padding(
  //                               padding: EdgeInsets.only(top: 1.v),
  //                               child: Text(
  //                                 "Computer Science",
  //                                 style: theme.textTheme.labelLarge,
  //                               ),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.only(left: 4.h, top: 1.v),
  //                             child: Text(
  //                               "•",
  //                               style: theme.textTheme.labelLarge,
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.only(left: 4.h),
  //                             child: Text(
  //                               "2019",
  //                               style: theme.textTheme.labelLarge,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  /// Navigates to the newPositionScreen when the action is triggered.
  onTapEditSquare(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          AddSkillsScreen()), // Replace AddSkillsScreen with the name of your screen
    );
  }
  void onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  void onTapImage1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }

  void onTapEditAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          PersonalInfoScreen()),
    );
  }
}