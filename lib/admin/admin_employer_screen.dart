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
    QuerySnapshot userDocs = await FirebaseFirestore.instance.collection('Users').where("role", isEqualTo: "e").get();
    List<UserModel> users = [];
    userDocs.docs.forEach((doc) {
      users.add(UserModel.fromSnapshot(doc.data() as Map<String, dynamic>)); // Assuming UserModel.fromJson is your model constructor
    });
    setState(() {
      allUserList = users;
      tempData = allUserList;
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
      appBar: AppBar(
        title: Text('Employers List'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _showFilterPopup(context);
        },
        child: Icon(Icons.filter_list, color: Colors.white), // Filter icon
      ),
      body: ListView.builder(
        itemCount: allUserList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allUserList[index].email ?? ""),
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
                                selectFilterDate.text =
                                    (selectedDate != null ? DateFormat("dd MMM,yyyy").format(selectedDate ?? DateTime.now()) : "");
                              });
                            }
                          },
                          icon: Icon(Icons.date_range),
                        )),
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
                          'Apply',
                          style: TextStyle(fontSize: 18, color: Colors.white), // Increase text size
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          allUserList = tempData;
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18, color: Colors.white), // Increase text size
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
}
