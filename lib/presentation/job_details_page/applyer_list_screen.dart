import 'dart:async';

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

  fetchDocumentList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("job_applications").get();

    List<Map<String, dynamic>> documentList = [];

    for (DocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String documentId = document.id;

      if (data['jobId'] == widget.jobId) {
        documentList.add({...data, 'id': documentId});
      }
    }

    data = documentList;

    data.forEach((element) async {
      QuerySnapshot snap = await FirebaseFirestore.instance.collection("Users").where('userId', isEqualTo: element['userId']).get();
      element['fullName'] = "${snap.docs.first['fname']} ${snap.docs.first['lname']}";
      setState(() {

      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
     print("-----------${data.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text('job_applications'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final fullName = data[index]['fullName'] as String?;
          print("-----------${data}");
          return ListTile(
            title: Text(data[index]['fullName'] ?? ""),
            onTap: () {
              Get.to(JobApplyerScreen(jobId: data[index]['id']));
            },
          );
          return null;
        },
      ),
    );
  }
}
