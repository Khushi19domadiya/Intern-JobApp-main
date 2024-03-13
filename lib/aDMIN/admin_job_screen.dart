import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminJobScreen extends StatefulWidget {
  const AdminJobScreen({super.key});

  @override
  State<AdminJobScreen> createState() => _AdminJobScreenState();
}

class _AdminJobScreenState extends State<AdminJobScreen> {

  List<PostJobModel> allJobList = [];
  fetchAllUsers() async {
    QuerySnapshot userDocs = await FirebaseFirestore.instance.collection('postJob').get();
    List<PostJobModel> jobs = [];
    userDocs.docs.forEach((doc) {
      jobs.add(PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>)); // Assuming UserModel.fromJson is your model constructor
    });
    setState(() {
      allJobList = jobs;
    });
    // Proceed with the rest of your logic here
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: allJobList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allJobList[index].title ??""),
          );
        },
      ),
    );
  }
}
