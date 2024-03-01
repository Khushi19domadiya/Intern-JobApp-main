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

class jobController extends GetxController{

  // RxList<postjobModel> jobDataList = <postjobModel>[].obs;
  User? user = FirebaseAuth.instance.currentUser;

  Future<List<PostJobModel>> fetchJobDataFromFirestore(String role) async {


log('----fetchJobDataFromFirestore----');
    final snapshot = await FirebaseFirestore.instance.collection('postJob').get();
    print("------------ ${snapshot.docs} ----------");
    List<PostJobModel>  jobData = snapshot.docs.map((e) => PostJobModel.fromSnapshot(e.data())).toList();


    if(role == 'e'){
      List<PostJobModel> myJobs = jobData.where((job) => job.userId == user!.uid).toList();
      return myJobs;

    }else{
      return jobData;

    }


    // print("done");
    // jobDataList.value = jobData;
    // print("done ....");
    // update();
    log("----fetchJobDataFromFirestore----");
    log("----jobData----" + jobData.length.toString());

  }

  Future<List<PostJobModel>> fetchUserPostedJobs(String? userId) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('postJob')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching user posted jobs: $e');
      return [];
    }
  }
}