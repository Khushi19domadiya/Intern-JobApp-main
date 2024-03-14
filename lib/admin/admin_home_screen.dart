import 'package:flutter/material.dart';
import 'package:saumil_s_application/admin/admin_employer_screen.dart';
import 'package:saumil_s_application/admin/admin_job_screen.dart';
import 'package:saumil_s_application/admin/admin_jobseeker_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
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
