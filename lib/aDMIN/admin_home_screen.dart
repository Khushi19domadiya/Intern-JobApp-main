import 'package:flutter/material.dart';
import 'package:saumil_s_application/aDMIN/admin_company_screen.dart';

import 'admin_job_screen.dart';
import 'admin_user_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter TabBar Example'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'user'),
              Tab(icon: Icon(Icons.business), text: 'compney'),
              Tab(icon: Icon(Icons.school), text: 'jobs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AdminUserScreen(),
            AdminCompanyScreen(),
            AdminJobScreen(),
          ],
        ),
      ),
    );
  }
}
