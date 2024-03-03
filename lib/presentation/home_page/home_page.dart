import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/presentation/notifications_general_page/notifications_general_page.dart';
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
import 'package:saumil_s_application/presentation/notifications_my_proposals_tab_container_screen/notifications_my_proposals_tab_container_screen.dart';

import '../home_container_screen/home_container_screen.dart';
import '../job_details_page/applyer_list_screen.dart';

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
RxList<PostJobModel> pOPJobs = <PostJobModel>[].obs;
   fetchUserRole() async {
    var userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(()  {
      userRole = userDoc['role'];
    });
    pOPJobs.value =    await controller.fetchUserPostedJobs(userId);
     // pOPJobs.sort((a, b) => a.applyCount.compareTo(b.name));
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
        .orderBy('title')
        .get();

    // Filter out records with a deadline that has already passed or equals the current date
    var validData = data.docs.where((doc) {
      var deadline = doc['deadline'] as Timestamp;
      return deadline.toDate().isAfter(DateTime.now());
    }).toList();

    setState(() {
      allResults = validData;
    });
  }


  // getClientStream() async {
  //   var currentTime = Timestamp.now();
  //   var data = await FirebaseFirestore.instance
  //       .collection('postJob')
  //       .where('deadline', isGreaterThan: currentTime) // Only fetch recommendations with a deadline after the current date
  //       .orderBy('title')
  //       .get();
  //   setState(() {
  //     allResults = data.docs;
  //   });
  // }

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
                            // controller: searchController,
                            onTap: (){
                              setState(() {
                                currentIndex.value = 2;
                              });

                            },
                            isRead : true,
                            autofocus: false,
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
                      GestureDetector(
                        onTap: (){
                          controller.fetchJobDataFromFirestore(userRole!);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: Text(
                            "Recommendation",
                            style: CustomTextStyles.titleMedium18,
                          ),
                        ),
                      ),
                      SizedBox(height: 17.v),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _buildFrame(context),
                      ),
                      SizedBox(height: 22.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Most Trending Jobs",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 15.v),
                      _buildTrendingJobs(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationsGeneralPage(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20), // Adjust margin as needed
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87,
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.white, // Change color to black or any other dark color
              size: 30,
            ),
          ),
        ),
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
              separatorBuilder: (
                  context,
                  index,
                  ) {
                return SizedBox(
                  height: 16.v,
                );
              },
              itemCount: 12,
              itemBuilder: (context, index) {
                return SizedBox();
                // return EightyeightItemWidget();
              },
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
            var userImage ='https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // User image or default image

            if (snapshot.data!.exists) {

              var data = snapshot.data!.data() as Map<String, dynamic>?;
              if (data != null && data.containsKey('profileUrl')) {
                userImage = data['profileUrl'];
                // Use fname here
              } else {
                // Handle case where 'fname' field does not exist
              }
            } else {
              // Handle case where document does not exist
            }

            // var userImage = snapshot.data!['profileUrl'] ?? ImageConstant.imgImage50x50; // User image or default image
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
            String userName = ''; // User name or default name

            if (snapshot.data!.exists) {

              var data = snapshot.data!.data() as Map<String, dynamic>?;
              if (data != null && data.containsKey('fname')) {
                var fname = data['fname'];
                userName = fname;
                // Use fname here
              } else {
                // Handle case where 'fname' field does not exist
              }
            } else {
              // Handle case where document does not exist
            }


            // String userName = snapshot.data!['fname'] ?? "User"; // User name or default name
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
    );
  }


  // Widget _buildFrame(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: FutureBuilder<List<PostJobModel>>(
  //       future: controller.fetchUserPostedJobs(userId), // Pass userId to fetch only user's posted jobs
  //       builder: (context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasData) {
  //           return Row(
  //             children: [
  //               ...List.generate(
  //                 snapshot.data!.length,
  //                     (index) => Padding(
  //                   padding: const EdgeInsets.only(left: 20),
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       PostJobModel model = snapshot.data[index];
  //                       if (userRole == "e") {
  //                         Get.to(() => ApplyerListScreen());
  //                       } else {
  //                         Get.to(() => ApplyJobScreen(jobId: model.id,));
  //                       }
  //                     },
  //                     child: FrameItemWidget(
  //                       model: snapshot.data[index],
  //                       searchQuery: searchController.text,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         } else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildFrame(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FutureBuilder<List<PostJobModel>>(
        future: userRole == 'j' ? controller.fetchJobDataFromFirestore(userRole!) : controller.fetchUserPostedJobs(userId),
        builder: (context, AsyncSnapshot<List<PostJobModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<PostJobModel>? jobData = snapshot.data;

            if (jobData == null || jobData.isEmpty) {
              return const Center(child: Text("No jobs available."));
            }

            return Row(
              children: jobData.map((model) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (userRole == "e") {


                        Get.to(() => ApplyerListScreen(jobId: model.id));
                      } else {
                        Get.to(() => ApplyJobScreen(jobId: model.id));
                      }
                    },
                    child: FrameItemWidget(
                      model: model,
                      searchQuery: searchController.text,
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }


  Widget _buildTrendingJobs() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('trendingJobs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No trending jobs available'));
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return EightyeightItemWidget(jobData: data);
          }).toList(),
        );
      },
    );
  }
}