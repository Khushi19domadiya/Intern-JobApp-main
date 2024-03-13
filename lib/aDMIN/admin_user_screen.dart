import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {

  List<UserModel> allUserList = [];
  fetchAllUsers() async {
      QuerySnapshot userDocs = await FirebaseFirestore.instance.collection('Users').where("role",isEqualTo: "j").get();
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
            title: Text(allUserList[index].email ??""),
          );
        },
      ),
    );
  }
}
