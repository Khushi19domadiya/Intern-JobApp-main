import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/presentation/post_job/post_job.dart';
import 'package:saumil_s_application/controller/jobController.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/presentation/apply_job_screen/apply_job_screen.dart';
import 'package:saumil_s_application/presentation/home_page/widgets/eightyeight_item_widget.dart';
import 'package:saumil_s_application/presentation/home_page/widgets/frame_item_widget.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_circleimage.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_subtitle.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_search_view.dart';
import 'package:saumil_s_application/presentation/sign_up_complete_account_screen/sign_up_complete_account_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  jobController controller = Get.put(jobController());
  String? userId;
  String? userRole;

  List allResults = [];
  List resultList = [];

  @override
  void initState() {
    super.initState();
    // Get the current user's ID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    getClientStream();
    searchController.addListener(_onSearchChanged);
    fetchUserRole();
  }

  void fetchUserRole() async {
    var userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(() {
      userRole = userDoc['role'];
    });
  }

  _onSearchChanged() {
    print(searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (searchController.text != "") {
      for (var clientSnapShot in allResults) {
        var title = clientSnapShot['title'].toString().toLowerCase();
        if (title.contains(searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }
    setState(() {
      resultList = showResults;
    });
  }

  getClientStream() async {
    var currentTime = Timestamp.now();
    var data = await FirebaseFirestore.instance
        .collection('postJob')
        .where('deadline', isGreaterThan: currentTime)
        .orderBy('title')
        .get();
    setState(() {
      allResults = data.docs;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.v),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.h),
                          child: CustomSearchView(
                            controller: searchController,
                            hintText: "Search...",
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.v),
                      if (userRole == 'e' || userRole == null)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 24.h),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostJob(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 25.h),
                                onPrimary: Colors.white,
                              ),
                              child: Text(
                                "Post Job",
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 25.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Recommendation",
                          style: CustomTextStyles.titleMedium18,
                        ),
                      ),
                      SizedBox(height: 17.v),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _buildFrame(context, userId.toString()),
                      ),
                      SizedBox(height: 22.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Recent Jobs",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 15.v),
                      _buildEightyEight(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 74.h,
      height: 85.h,
      leading: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: AppbarLeadingCircleimage(
                imagePath: ImageConstant.imgImage50x50, // Placeholder image
              ),
            );
          }
          if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: AppbarLeadingCircleimage(
                imagePath: ImageConstant.imgImage50x50, // Placeholder image
              ),
            );
          }
          if (snapshot.hasData) {
            var userImage = snapshot.data!['profileUrl'] ?? ImageConstant.imgImage50x50; // User image or default image
            return Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: CircleAvatar(
                radius: 20.h, // Adjust the size as needed
                backgroundImage: NetworkImage(userImage),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: 24.h),
            child: AppbarLeadingCircleimage(
              imagePath: ImageConstant.imgImage50x50, // Placeholder image
            ),
          );
        },
      ),
      title: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                AppbarSubtitle(
                  text: "Welcome! 👋",
                ),
                SizedBox(height: 9.v),
                AppbarSubtitleOne(
                  text: "Find your dream job",
                  margin: EdgeInsets.only(right: 33.h),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Column(
              children: [
                AppbarSubtitle(
                  text: "Welcome! 👋",
                ),
                SizedBox(height: 9.v),
                AppbarSubtitleOne(
                  text: "Find your dream job",
                  margin: EdgeInsets.only(right: 33.h),
                ),
              ],
            );
          }
          if (snapshot.hasData) {
            var userName = snapshot.data!['fname'] ?? "User"; // User name or default name
            return Column(
              children: [
                AppbarSubtitle(
                  text: "Welcome, $userName! 👋",
                ),
                SizedBox(height: 9.v),
                AppbarSubtitleOne(
                  text: "Find your dream job",
                  margin: EdgeInsets.only(right: 33.h),
                ),
              ],
            );
          }
          return Column(
            children: [
              AppbarSubtitle(
                text: "Welcome! 👋",
              ),
              SizedBox(height: 9.v),
              AppbarSubtitleOne(
                text: "Find your dream job",
                margin: EdgeInsets.only(right: 33.h),
              ),
            ],
          );
        },
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotification,
          margin: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 13.v,
          ),
        ),
      ],
    );
  }

  Widget _buildFrame(BuildContext context, String userId) {
    return Align(
      alignment: Alignment.centerRight,
      child: FutureBuilder<List<PostJobModel>>(
        future: controller.fetchJobDataFromFirestore(userRole ?? "j"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                ...List.generate(
                  snapshot.data!.length,
                      (index) => Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: FrameItemWidget(
                      onTapBag: () {
                        PostJobModel model = snapshot.data[index];
                        Get.to(() => ApplyJobScreen(jobId: model.id));
                      },
                      model: snapshot.data[index],
                      searchQuery: searchController.text,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildEightyEight(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.v);
          },
          itemCount: 12,
          itemBuilder: (context, index) {
            return EightyeightItemWidget();
          },
        ),
      ),
    );
  }
}
