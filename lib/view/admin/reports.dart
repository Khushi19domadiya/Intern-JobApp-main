import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:job_app/model/user_model.dart';

class Reports extends StatefulWidget {
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<PostJobModel> list1 = [];
  List<PostJobModel> list2 = [];
  List<PostJobModel> list3 = [];
  List<PostJobModel> list4 = [];
  List<PostJobModel> postJobs = [];
  getData() async {
    QuerySnapshot userDocs =
        await FirebaseFirestore.instance.collection('postJob').get();

    userDocs.docs.forEach((doc) {
      postJobs.add(PostJobModel.fromSnapshot(doc.data() as Map<String,
          dynamic>)); // Assuming UserModel.fromJson is your model constructor
    });
    postJobs.forEach((element) {
      if (element.selectedSourceOption?.toLowerCase() ==
          "Newspaper".toLowerCase()) {
        list1.add(element);
      } else if (element.selectedSourceOption?.toLowerCase() ==
          "Social media".toLowerCase()) {
        list2.add(element);
      } else if (element.selectedSourceOption?.toLowerCase() ==
          "Application".toLowerCase()) {
        list3.add(element);
      } else if (element.selectedSourceOption?.toLowerCase() ==
          "Poster".toLowerCase()) {
        list4.add(element);
      }
    });
    print("--------------->>>>>>>>>${list1.length}");
    print("${list2.length}");
    print("${list3.length}");
    print("${list4.length}");
    print("${postJobs.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: postJobs.isEmpty
                        ? CircularProgressIndicator()
                        : PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                    color: Colors.blue,
                                    value: list1.length /
                                        postJobs.length *
                                        100, // Adjust these values as needed
                                    title:
                                        'Newspaper\n${(list1.length / postJobs.length * 100).toStringAsFixed(2)}%', // Adjust these values as needed
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.black)),
                                PieChartSectionData(
                                    color: Colors.green,
                                    value: list2.length /
                                        postJobs.length *
                                        100, // Adjust these values as needed
                                    title:
                                        'Social media\n${(list2.length / postJobs.length * 100).toStringAsFixed(2)}%', // Adjust these values as needed
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.black)),
                                PieChartSectionData(
                                    color: Colors.orange,
                                    value: list3.length /
                                        postJobs.length *
                                        100, // Adjust these values as needed
                                    title:
                                        'Application\n${(list3.length / postJobs.length * 100).toStringAsFixed(2)}%', // Adjust these values as needed
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.black)),
                                PieChartSectionData(
                                    color: Colors.red,
                                    value: list4.length /
                                        postJobs.length *
                                        100, // Adjust these values as needed
                                    title:
                                        'Poster\n${(list4.length / postJobs.length * 100).toStringAsFixed(2)}%', // Adjust these values as needed
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem(Colors.blue, 'Newspaper'),
                    SizedBox(height: 30),
                    _buildLegendItem(Colors.green, 'Social media'),
                    SizedBox(height: 30),
                    _buildLegendItem(Colors.orange, 'Application'),
                    SizedBox(height: 30),
                    _buildLegendItem(Colors.red, 'Poster'),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
