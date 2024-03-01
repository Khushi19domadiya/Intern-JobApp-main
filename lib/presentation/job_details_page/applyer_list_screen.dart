import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'job_applyer_screen.dart';

// ApplyerListScreen

class ApplyerListScreen extends StatefulWidget {
  String? jobId;
  ApplyerListScreen({required this.jobId});

  @override
  State<ApplyerListScreen> createState() => _ApplyerListScreenState();
}

class _ApplyerListScreenState extends State<ApplyerListScreen> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchDocumentList();
  }

  Future<void> fetchDocumentList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("job_applications")
          .get();

      List<Map<String, dynamic>> documentList = [];

      for (DocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> data =
        document.data() as Map<String, dynamic>;
        String documentId = document.id;


        if(data['jobId']== widget.jobId){
        documentList.add({...data, 'id': documentId});}
      }

      setState(() {
        data = documentList;
      });
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['full_name']),
            onTap: () {
              Get.to(JobApplyerScreen(jobId: data[index]['id']));
            },
          );
        },
      ),
    );
  }
}
