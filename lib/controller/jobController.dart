import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/user_repository/user_repository.dart';

class jobController extends GetxController{

  // RxList<postjobModel> jobDataList = <postjobModel>[].obs;

  Future<List<postjobModel>> fetchJobDataFromFirestore() async {

    final snapshot = await FirebaseFirestore.instance.collection('postJob').get();
    print("------------ ${snapshot.docs} ----------");
    // List<postjobModel> jobdata = [];

    List<postjobModel>  jobData = snapshot.docs.map((e) => postjobModel.fromSnapshot(e.data())).toList();

    // print("done");
    // jobDataList.value = jobData;
    // print("done ....");
    // update();
    log("----fetchJobDataFromFirestore----");
    log("----jobData----" + jobData.length.toString());

    return jobData;
  }
}