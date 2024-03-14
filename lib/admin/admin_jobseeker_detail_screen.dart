import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminJobseekerDetailScreen extends StatelessWidget {
  final UserModel user;

  const AdminJobseekerDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobseeker Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: ${user.email}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
