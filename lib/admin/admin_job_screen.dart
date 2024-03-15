import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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

  TextEditingController selectFilterDate = TextEditingController();
  DateTime? selectedDate;
  List<UserModel> tempData = [];



  _showFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter by Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //     final DateTime? picked = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime.now(), // Set lastDate to today
              //     );
              //     if (picked != null && picked != selectedDate) {
              //       setState(() {
              //         selectedDate = picked;
              //       });
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40), // Adjust padding as needed
              //   ),
              //   child: Text(
              //     selectedDate == null ? 'Select Date' : 'Change Date',
              //     style: TextStyle(fontSize: 18,color: Colors.white), // Increase text size
              //   ),
              // ),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: selectFilterDate,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: "Select Date",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(), // Set lastDate to today
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              selectFilterDate.text = (selectedDate != null ? DateFormat("dd MMM,yyyy").format(selectedDate ?? DateTime.now()) : "");
                            });
                          }
                        },
                        icon: Icon(Icons.date_range),
                      )),
                ),
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     tempData.forEach((element) {
              //       print(element.registrationDateTime);
              //       print(element.email);
              //     });
              //     // allJobList = tempData
              //     //     .where((element) =>
              //     // ((element.registrationDateTime?.isEmpty ?? true)
              //     //     ? ""
              //     //     : DateFormat("YYYYMMDD").format(DateTime.parse(element.registrationDateTime ?? ""))) ==
              //     //     DateFormat("YYYYMMDD").format(selectedDate!))
              //     //     .toList();
              //     Navigator.of(context).pop();
              //     setState(() {});
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
              //   ),
              //   child: Text(
              //     'Apply Now',
              //     style: TextStyle(fontSize: 18, color: Colors.white), // Increase text size
              //   ),
              // ),

              ElevatedButton(
                onPressed: () {
                  if (selectedDate != null) {
                    // Filter the job list based on the selected date
                    // List<PostJobModel> filteredJobs = allJobList.where((job) {
                    //   return job.postJobDate == DateFormat("yyyyMMdd").format(selectedDate!);
                    // }).toList();

                    // Update the job list with the filtered jobs
                    // setState(() {
                    //   allJobList = filteredJobs;
                    // });
                  }
                  Navigator.of(context).pop(); // Close the filter dialog
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                ),
                child: Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),


            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
