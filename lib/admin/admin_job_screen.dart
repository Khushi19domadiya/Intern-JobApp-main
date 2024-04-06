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
      tempData = allJobList;
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
      appBar: AppBar(
        title: Text('Posted Jobs'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _showFilterPopup(context);
        },
        child: Icon(Icons.filter_list, color: Colors.white), // Filter icon
      ),
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
  List<PostJobModel> tempData = [];

  _showFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.all(10),
          title: Text('Filter by Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              selectFilterDate.text = (selectedDate != null
                                  ? DateFormat("dd MMM,yyyy").format(selectedDate ?? DateTime.now())
                                  : "");
                            });
                          }
                        },
                        icon: Icon(Icons.date_range),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          tempData.forEach((element) {
                            print(element.createAt);
                          });
                          allJobList = tempData
                              .where((element) =>
                          ((element.createAt?.isEmpty ?? true)
                              ? ""
                              : DateFormat("YYYYMMDD").format(DateTime.parse(element.createAt ?? ""))) ==
                              DateFormat("YYYYMMDD").format(selectedDate!))
                              .toList();
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                        ),
                        child: Text(
                          'Apply',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          allJobList = tempData;
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
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
