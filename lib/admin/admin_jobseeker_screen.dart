import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/models/user_model.dart';
// import 'package:saumil_s_application/screens/admin_jobseeker_detail_screen.dart';

import 'admin_jobseeker_detail_screen.dart';

class AdminJobseekerScreen extends StatefulWidget {
  const AdminJobseekerScreen({Key? key});

  @override
  State<AdminJobseekerScreen> createState() => _AdminJobseekerScreenState();
}

class _AdminJobseekerScreenState extends State<AdminJobseekerScreen> {
  List<UserModel> allUserList = [];

  Future<void> fetchAllUsers() async {
    QuerySnapshot userDocs =
    await FirebaseFirestore.instance.collection('Users').where("role", isEqualTo: "j").get();
    List<UserModel> users = [];
    userDocs.docs.forEach((doc) {
      users.add(UserModel.fromMap(doc.data())); // Assuming UserModel.fromJson is your model constructor
    });
    setState(() {
      allUserList = users;
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
        itemCount: allUserList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allUserList[index].email ?? ""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminJobseekerDetailScreen(user: allUserList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
