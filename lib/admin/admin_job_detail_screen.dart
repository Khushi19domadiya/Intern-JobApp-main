import 'package:flutter/material.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminJobDetailScreen extends StatelessWidget {
  final PostJobModel job;

  const AdminJobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              'Title: ${job.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text('Address: ${job.address}'),
            SizedBox(height: 15),
            Text('Description: ${job.about}'),
            SizedBox(height: 15),
            Text('Deadline: ${job.deadline}'),
            SizedBox(height: 15),
            Text('Experience: ${job.experience}'),
            SizedBox(height: 15),
            Text('Gender: ${job.gender}'),
            SizedBox(height: 15),
            Text('Highest Salary: ${job.highestsalary}'),
            SizedBox(height: 15),
            Text('Lowest Salary: ${job.lowestsalary}'),
            SizedBox(height: 15),
            Text('Job Type: ${job.jobType}'),
            SizedBox(height: 15),
            Text('Category of job: ${job.selectedOption}'),
            SizedBox(height: 15),
            Text('Skills: ${job.selectedSkills}'),
            // Add more job details as needed
          ],
        ),
      ),
    );
  }
}
