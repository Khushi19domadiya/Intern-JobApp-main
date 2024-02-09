import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'job_applyer_screen.dart';

class ApplyerListScreen extends StatefulWidget {
  Key? key;
   ApplyerListScreen({this.key});

  @override
  State<ApplyerListScreen> createState() => _ApplyerListScreenState();
}

class _ApplyerListScreenState extends State<ApplyerListScreen> {
List data= [];
  @override
  void initState() {
    super.initState();
    // Get the current user's ID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    fetchDocumentList();
  }

  Future<List<Map<String, dynamic>>> fetchDocumentList() async {
    CollectionReference jobCollection = FirebaseFirestore.instance.collection("job_applications");

    try {
      QuerySnapshot querySnapshot = await jobCollection.get();

      List<DocumentSnapshot> documents = querySnapshot.docs;

      List<Map<String, dynamic>> documentList = [];

      // Now you can iterate over the documents list to access each document
      for (DocumentSnapshot document in documents) {
        // Access document data using document.data()
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Access document ID using document.id
        String documentId = document.id;
        // Add document data along with ID to the list
        documentList.add({...data, 'id': documentId});
      }
      print("v fetching documents: $documentList");
      data = documentList;
      setState(() {

      });
      return documentList;
    } catch (e) {
      // Handle errors here
      print("Error fetching documents: $e");
      return []; // Return an empty list in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appler'),

      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          // Build each list item based on index
          return ListTile(
            title: Text(data[index]['full_name']),
            onTap: () {
              Get.to(() => JobApplyerScreen(jobId: data[index]['jobId'],));

              // Handle item tap if needed
              // print('Tapped on ${dataList[index]}');
            },
          );
        },
      ),
    );
  }
}
