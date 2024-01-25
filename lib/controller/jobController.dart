import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/user_repository/user_repository.dart';

class jobController extends GetxController{

  RxList<postjobModel> jobDataList = <postjobModel>[].obs;
  Future<List<postjobModel>> fetchJobDataFromFirestore() async {

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('postJob').get();

    List<postjobModel> jobData = querySnapshot.docs.map((doc) {

      return postjobModel.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      });
    }).toList();
    jobDataList.value = jobData;
    update();
    log("----fetchJobDataFromFirestore----");
    log("----jobData----" + jobData.length.toString());

    return jobData;
  }
}