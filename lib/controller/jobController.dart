import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/user_repository/user_repository.dart';

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/user_repository/user_repository.dart';

class JobController extends GetxController{
  String? selectedJobType;
  String? selectedCategory;
  RxDouble minSalary =RxDouble(5000.0);
  RxDouble maxSalary =RxDouble(100000.0);
  RxList<PostJobModel> tempSearchJob = <PostJobModel>[].obs;
  RxList<PostJobModel> jobList = <PostJobModel>[].obs;
  RxBool isLoading = false.obs;
  String? userRole;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<List<PostJobModel>> getJobsFuture() async {
    if (userRole == 'e') {
      // Fetch only current user's posted jobs
      return fetchUserPostedJobs(user!.uid);
    } else {
      // Fetch all jobs
      return fetchJobDataFromFirestore(userRole!);
    }
  }
  Future getFilteredJobs() async {
    List<PostJobModel> filteredJobs = [];
    log("----selectedJobType---${selectedJobType}");
    log("----selectedCategory---${selectedCategory}");
    // Filter job list based on selected criteria
    filteredJobs = tempSearchJob.where((job) {
      bool matchesJobCategory = true;
      bool matchesSelectedCategories = true;
      bool matchesSalaryRange = true;
      bool matchesType = true;

      // Filter by job category
      if (selectedJobType != null && selectedJobType != '') {
        // matchesJobCategory = (job.jobType == selectedJobType);
        matchesJobCategory = (job.selectedOption == selectedCategory);
      }

      // Filter by selected categories
      if (selectedCategory != null && selectedCategory != '') {
        // Split selected categories into a list
        List<String> selectedCategoriesList = selectedCategory!.split(',');

        // Check if any of the selected categories match job's selectedOption
        matchesSelectedCategories = selectedCategoriesList.contains(job.selectedOption);
      }

      // Convert minSalary and maxSalary from string to double for comparison
      double? minSalary = double.tryParse(job.lowestsalary);
      double? maxSalary = double.tryParse(job.highestsalary);

      // Check if conversion was successful before comparison
      if (minSalary != null && maxSalary != null && minSalary != null && maxSalary != null) {
        // Filter by salary range
        matchesSalaryRange = minSalary >= minSalary! && maxSalary <= maxSalary!;
      }

      // Filter by type
      if (selectedJobType != null && selectedJobType != '') {
        matchesType = (job.jobType == selectedJobType);
      }

      // Include job if it matches job category, selected categories, salary range, and type
      return matchesJobCategory && matchesSelectedCategories && matchesSalaryRange && matchesType;
    }).toList();
    jobList.value = filteredJobs;
    jobList.refresh();
    update();
    // return filteredJobs!;
  }


  // RxList<postjobModel> jobDataList = <postjobModel>[].obs;

  Future<List<PostJobModel>>  fetchJobDataFromFirestore(String role) async {
    try {
      log('----fetchJobDataFromFirestore----');
      final snapshot = await FirebaseFirestore.instance.collection('postJob')
          .get();
      print("------------ ${snapshot.docs} ----------");
      List<PostJobModel> jobData = snapshot.docs.map((e) =>
          PostJobModel.fromSnapshot(e.data())).toList();


      jobData = jobData.where((job) {
        var deadlineDateTime = DateTime.parse(job.deadline);
        return deadlineDateTime.isAfter(DateTime.now());
      }).toList();

      return jobData;
    } catch (e) {
      print('Error fetching job data: $e');
      return [];
    }
  }
  // if(role == 'e'){
  //   List<PostJobModel> myJobs = jobData.where((job) => job.userId == user!.uid).toList();
  //   return myJobs;
  //
  // }else{
  //   return jobData;
  //
  // }



  // print("done");
  // jobDataList.value = jobData;
  // print("done ....");
  // update();
  // log("----fetchJobDataFromFirestore----");
  // log("----jobData----" + jobData.length.toString());




  // getClientStream() async {
  //   var currentTime = Timestamp.now();
  //   var data = await FirebaseFirestore.instance
  //       .collection('postJob')
  //       .orderBy('title')
  //       .get();
  //
  //   // Filter out records with a deadline that has already passed or equals the current date
  //   var validData = data.docs.where((doc) {
  //     var deadline = doc['deadline'] as Timestamp;
  //     return deadline.toDate().isAfter(DateTime.now());
  //   }).toList();
  //
  //   setState(() {
  //     allResults = validData;
  //   });
  // }


  // Future<List<PostJobModel>> fetchUserPostedJobs(String? userId) async {
  //   try {
  //     var currentTime = Timestamp.now();
  //     var querySnapshot = await FirebaseFirestore.instance
  //         .collection('postJob')
  //         .where('userId', isEqualTo: userId)
  //         .where('deadline', isGreaterThan: currentTime) // Add deadline filtering
  //         .get();
  //     return querySnapshot.docs
  //         .map((doc) => PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching user posted jobs: $e');
  //     return [];
  //   }
  // }

  // Future<List<PostJobModel>> fetchUserPostedJobs(String? userId) async {
  //   try {
  //     var currentTime = Timestamp.now();
  //     var querySnapshot = await FirebaseFirestore.instance
  //         .collection('postJob')
  //         .where('userId', isEqualTo: userId)
  //         .get(); // Fetch all user posted jobs
  //
  //     // Filter out records with a valid deadline that is after the current time
  //     var validData = querySnapshot.docs.where((doc) {
  //       log("------doc['deadline']-------${doc['deadline']}");
  //       var deadline = doc['deadline'];
  //       if (deadline is Timestamp) {
  //         log("-----true-----");
  //         return (deadline as Timestamp).toDate().isAfter(DateTime.now());
  //       } else {
  //         log("-----false-----");
  //
  //         return false;
  //       }
  //     }).toList();
  //
  //     return validData
  //         .map((doc) => PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching user posted jobs: $e');
  //     return [];
  //   }
  // }


  Future<List<PostJobModel>> fetchUserPostedJobs(String? userId) async {
    try {
      var currentTime = DateTime.now();
      var querySnapshot = await FirebaseFirestore.instance
          .collection('postJob')
          .where('userId', isEqualTo: userId)
          .get(); // Fetch all user posted jobs

      // Filter out records with a valid deadline that is after the current time
      var validData = querySnapshot.docs.where((doc) {
        var deadline = doc['deadline'];
        if (deadline is String) {
          var deadlineDateTime = DateTime.parse(deadline); // Parse the string to DateTime
          return deadlineDateTime.isAfter(currentTime);
        } else {
          return false;
        }
      }).toList();

      return validData
          .map((doc) => PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching user posted jobs: $e');
      return [];
    }
  }



  Future<List<PostJobModel>> fetchSelectionFilterJobs(String? userId,String selection) async {
    try {
      var currentTime = DateTime.now();
      var querySnapshot = await FirebaseFirestore.instance
          .collection('postJob')
          .where('userId', isEqualTo: userId)
          .get(); // Fetch all user posted jobs

      // Filter out records with a valid deadline that is after the current time
      var validData = querySnapshot.docs.where((doc) {
        var deadline = doc['deadline'];
        if (deadline is String) {
          var deadlineDateTime = DateTime.parse(deadline); // Parse the string to DateTime
          return deadlineDateTime.isAfter(currentTime);
        } else {
          return false;
        }
      }).toList();

      return validData
          .map((doc) => PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching user posted jobs: $e');
      return [];
    }
  }





// Future<List<PostJobModel>> fetchUserPostedJobs(String? userId) async {
//   try {
//     var querySnapshot = await FirebaseFirestore.instance
//         .collection('postJob')
//         .where('userId', isEqualTo: userId)
//         .get();
//     return querySnapshot.docs
//         .map((doc) => PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>))
//         .toList();
//   } catch (e) {
//     print('Error fetching user posted jobs: $e');
//     return [];
//   }
// }
}