import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saumil_s_application/admin/admin_employer_screen.dart';
import 'package:saumil_s_application/admin/admin_job_screen.dart';
import 'package:saumil_s_application/admin/admin_jobseeker_screen.dart';

import '../presentation/sign_up_create_acount_screen/sign_up_create_acount_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    AdminJobseekerScreen(),
    AdminEmployerScreen(),
    AdminJobScreen(),
  ];


  RxInt selectInt =  0.obs;

  DateTime? selectedDate;

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
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                selectInt.value = _selectedIndex;
              });
            },
            tabs: [
              Tab(
                icon: Icon(Icons.group),
                text: 'Job Seekers',
              ),
              Tab(
                icon: Icon(Icons.business),
                text: 'Employers',
              ),
              Tab(
                icon: Icon(Icons.work),
                text: 'Posted Jobs',
              ),
            ],
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(1.0),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeInOut,
              )),
              child: _tabs[_selectedIndex],
            ),
          ),
        ),
      ),
    );
  }
}
