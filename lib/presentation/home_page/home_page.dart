import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/presentation/post_job/post_job.dart';

import '../../controller/jobController.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_elevated_button.dart';
import '../home_page/widgets/eightyeight_item_widget.dart';
import '../home_page/widgets/frame_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_circleimage.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_subtitle.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_search_view.dart';

import '../sign_up_complete_account_screen/sign_up_complete_account_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  jobController controller = Get.put(jobController());

  List allResults = [];
  List resultList = [];

  void initState() {
    getClientStream();
    searchController.addListener(_onSearchChanged);
    super.initState();
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
    var data = await FirebaseFirestore.instance.collection('postJob').orderBy('title').get();
    setState(() {
      allResults = data.docs;
    });
  }

  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
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
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 24.h),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PostJob()),
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
                        child: _buildFrame(context),
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
      leading: AppbarLeadingCircleimage(
        imagePath: ImageConstant.imgImage50x50,
        margin: EdgeInsets.only(left: 24.h),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 10.h, top: 10.h),
        child: Column(
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
        ),
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

  Widget _buildSaveChanges(BuildContext context) {
    return CustomElevatedButton(
      text: "Save Changes",
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 37.v),
      onPressed: () {},
    );
  }

  Widget _buildFrame(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          FutureBuilder<List<postjobModel>>(
            future: controller.fetchJobDataFromFirestore(),
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
                            onTapBag(context);
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
        ],
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
            return EightyeightItemWidget();
          },
        ),
      ),
    );
  }

  onTapBag(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.jobDetailsTabContainerScreen);
  }
}
