import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminJobseekerDetailScreen extends StatelessWidget {
  final UserModel user;

  const AdminJobseekerDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Seeker Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('First Name: ${user.fname}'),
            Text('Last Name: ${user.lname}'),
            Text('Email: ${user.email}'),
            Text('Phone Number: ${user.phonenumber}'),
            Text('About: ${user.about}'),
            Text('Address: ${user.address}'),
            Text('Skills: ${user.skills}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
