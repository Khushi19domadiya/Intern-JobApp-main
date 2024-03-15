import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saumil_s_application/admin/admin_employer_detail_screen.dart';
import 'package:saumil_s_application/models/user_model.dart';

class AdminEmployerScreen extends StatefulWidget {
  const AdminEmployerScreen({super.key});

  @override
  State<AdminEmployerScreen> createState() => _AdminEmployerScreenState();
}

class _AdminEmployerScreenState extends State<AdminEmployerScreen> {

  List<UserModel> allUserList = [];
  fetchAllUsers() async {
    QuerySnapshot userDocs = await FirebaseFirestore.instance.collection('Users').where("role",isEqualTo: "e").get();
    List<UserModel> users = [];
    userDocs.docs.forEach((doc) {
      users.add(UserModel.fromMap(doc.data())); // Assuming UserModel.fromJson is your model constructor
    });
    setState(() {
      allUserList = users;
    });
    // Proceed with the rest of your logic here
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          _showFilterPopup(context);
        },
      ),
      body: ListView.builder(
        itemCount: allUserList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allUserList[index].email ??""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminEmployerDetailScreen(user: allUserList[index]),
                ),
              );
            },
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
              ElevatedButton(
                onPressed: () {
                  tempData.forEach((element) {
                    print(element.registrationDateTime);
                    print(element.email);
                  });
                  allUserList = tempData
                      .where((element) =>
                  ((element.registrationDateTime?.isEmpty ?? true)
                      ? ""
                      : DateFormat("YYYYMMDD").format(DateTime.parse(element.registrationDateTime ?? ""))) ==
                      DateFormat("YYYYMMDD").format(selectedDate!))
                      .toList();
                  Navigator.of(context).pop();
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                ),
                child: Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 18, color: Colors.white), // Increase text size
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
