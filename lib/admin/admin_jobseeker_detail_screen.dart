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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              'First Name: ${user.fname}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text('Last Name: ${user.lname}'),
            SizedBox(height: 15),
            Text('Email: ${user.email}'),
            SizedBox(height: 15),
            Text('Phone Number: ${user.phonenumber}'),
            SizedBox(height: 15),
            Text('About: ${user.about}'),
            SizedBox(height: 15),
            Text('Address: ${user.address}'),
            SizedBox(height: 15),
            Text('Skills: ${user.skills}'),
            SizedBox(height: 15),
            Text('Status: ${user.status}'),
            SizedBox(height: 15),
            Text('User Role: ${user.role}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
