import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminEmployerScreen extends StatefulWidget {
  const AdminEmployerScreen({super.key});

  @override
  State<AdminEmployerScreen> createState() => _AdminEmployerScreenState();
}

class _AdminEmployerScreenState extends State<AdminEmployerScreen> {

  List<UserModel> allUserList = [];
  fetchAllUsers() async {
    QuerySnapshot userDocs = await FirebaseFirestore.instance.collection('Users').where("role",isEqualTo: "e").get();
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
