import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_app/view/admin/admin_employer_screen.dart';
import 'package:job_app/view/admin/admin_job_screen.dart';
import 'package:job_app/view/admin/admin_jobseeker_screen.dart';
import 'package:job_app/view/admin/reports.dart';

import '../presentation/sign_up_create_acount_screen/sign_up_create_acount_screen.dart';
import 'admin_home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState(); // Renamed to DashboardState
}

class DashboardState extends State<Dashboard> { // Renamed to DashboardState

  int totalEmployers = 0;
  int totalJobSeekers = 0;
  int totalPostedJobs = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalData();
  }

  void _fetchTotalData() async {
    // Fetch total employers
    QuerySnapshot<Map<String, dynamic>> employersSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('role', isEqualTo: 'e')
        .get();
    int employersCount = employersSnapshot.docs.length;

    // Fetch total job seekers
    QuerySnapshot<Map<String, dynamic>> jobSeekersSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('role', isEqualTo: 'j')
        .get();
    int jobSeekersCount = jobSeekersSnapshot.docs.length;

    // Fetch total posted jobs
    QuerySnapshot<Map<String, dynamic>> postedJobsSnapshot = await FirebaseFirestore.instance
        .collection('postJob')
        .get();
    int postedJobsCount = postedJobsSnapshot.docs.length;

    setState(() {
      totalEmployers = employersCount;
      totalJobSeekers = jobSeekersCount;
      totalPostedJobs = postedJobsCount;
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false, // Remove back button
          title: Row(
            children: [
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
              Spacer(),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Implement your logout logic here
                Get.to(SignUpCreateAcountScreen());
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],

        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildDashboardItem('Total Employers', totalEmployers, Icons.group, Colors.blue),
                _buildDashboardItem('Total Job Seekers', totalJobSeekers, Icons.business, Colors.green),
                _buildDashboardItem('Total Posted Jobs', totalPostedJobs, Icons.work, Colors.orange),
                _buildRoundGraph(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardItem(String title, int count, IconData iconData, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == 'Total Employers') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminEmployerScreen()),
          );
        }
        if (title == 'Total Job Seekers') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminJobseekerScreen()),
          );
        }
        if (title == 'Total Posted Jobs') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminJobScreen()),
          );
        }
      },
      child: Container(
        width: 300, // Adjust the width as needed
        child: Card(
          margin: EdgeInsets.only(top: 40),
          elevation: 4, // Add elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconData,
                  size: 40,
                  color: color,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          count.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          title == 'Total Employers' ? 'Employers' : (title == 'Total Job Seekers' ? 'Job Seekers' : 'Posted Jobs'),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildRoundGraph() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(20), // Rounded corners
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.5),
  //             spreadRadius: 2,
  //             blurRadius: 5,
  //             offset: Offset(0, 3), // Shadow position
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Round Graph',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.indigo,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Container(
  //               height: 200,
  //               child: PieChart(
  //                 PieChartData(
  //                   sections: [
  //                     if (totalEmployers > 0)
  //                       PieChartSectionData(
  //                         color: Colors.blue,
  //                         value: totalEmployers.toDouble(),
  //                         title: totalEmployers.toString(),
  //                         radius: 50,
  //                       ),
  //                     if (totalJobSeekers > 0)
  //                       PieChartSectionData(
  //                         color: Colors.green,
  //                         value: totalJobSeekers.toDouble(),
  //                         title: totalJobSeekers.toString(),
  //                         radius: 50,
  //                       ),
  //                     if (totalPostedJobs > 0)
  //                       PieChartSectionData(
  //                         color: Colors.orange,
  //                         value: totalPostedJobs.toDouble(),
  //                         title: totalPostedJobs.toString(),
  //                         radius: 50,
  //                       ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRoundGraph() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Reports()), // Navigate to the Reports widget
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Round Graph',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        if (totalEmployers > 0)
                          PieChartSectionData(
                            color: Colors.blue,
                            value: totalEmployers.toDouble(),
                            title: totalEmployers.toString(),
                            radius: 50,
                          ),
                        if (totalJobSeekers > 0)
                          PieChartSectionData(
                            color: Colors.green,
                            value: totalJobSeekers.toDouble(),
                            title: totalJobSeekers.toString(),
                            radius: 50,
                          ),
                        if (totalPostedJobs > 0)
                          PieChartSectionData(
                            color: Colors.orange,
                            value: totalPostedJobs.toDouble(),
                            title: totalPostedJobs.toString(),
                            radius: 50,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}