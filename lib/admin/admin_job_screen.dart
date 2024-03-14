import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/admin/admin_job_detail_screen.dart';

class AdminJobScreen extends StatefulWidget {
  const AdminJobScreen({Key? key}) : super(key: key);

  @override
  State<AdminJobScreen> createState() => _AdminJobScreenState();
}

class _AdminJobScreenState extends State<AdminJobScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<PostJobModel> allJobList = [];

  fetchAllJobs() async {
    QuerySnapshot jobDocs = await FirebaseFirestore.instance.collection('postJob').get();
    List<PostJobModel> jobs = [];
    jobDocs.docs.forEach((doc) {
      jobs.add(PostJobModel.fromSnapshot(doc.data() as Map<String, dynamic>));
    });
    setState(() {
      allJobList = jobs;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllJobs();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: ListView.builder(
              itemCount: allJobList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allJobList[index].title ?? ""),
                  onTap: () {
                    // Navigate to job detail screen when the user taps on a job
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminJobDetailScreen(job: allJobList[index]),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
