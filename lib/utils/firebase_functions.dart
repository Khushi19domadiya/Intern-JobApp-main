import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_app/model/job_app_model.dart';
import 'package:job_app/model/user_model.dart';

class AppFunctions{

  Future getJobApplierData(String jobId) async {

    JobApplicationModel? model;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("job_applications")
          .where('id', isEqualTo: jobId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        model = JobApplicationModel.fromSnapshot(snapshot.docs[0].data() as Map<String, dynamic>);
      } else {
        print('Data not found !');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return model;
  }

  Future<UserModel?> getUserData(String userId) async {

    UserModel? model;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        model = UserModel.fromSnapshot(snapshot.docs[0].data() as Map<String, dynamic>);
      } else {
        print('Data not found !');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return model;
  }

  Future updateApplicationStatus({required String docId, int status = 2}) async{
    await FirebaseFirestore.instance
        .collection('job_applications')
        .doc(docId)
        .update({'status': status});
  }

  Future<bool> checkApplication({required String userId, required String jobId}) async {
    bool status = false;
    List<JobApplicationModel> list;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('job_applications')
        .get();

    list = snapshot.docs.map((doc) => JobApplicationModel.fromSnapshot(doc.data() as Map<String, dynamic>)).toList();;

    list.forEach((obj) {
      if(obj.userId == userId && obj.jobId == jobId){
        status = true;
        return;
      }
    });

    return status;
  }
}