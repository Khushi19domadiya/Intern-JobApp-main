import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminEmployerDetailScreen extends StatelessWidget {
  final UserModel user;

  const AdminEmployerDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employer Details'),
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
            Text('About: ${user.profile}'),
            SizedBox(height: 15),
            Text('Address: ${user.address}'),
            SizedBox(height: 15),
            Text('Skills: ${user.skills}'),
            SizedBox(height: 15),
            Text('User Role: ${user.role}'),
            // SizedBox(height: 15),
            // Text(': ${user.}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
