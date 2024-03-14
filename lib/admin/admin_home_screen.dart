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

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
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
              IconButton(
                icon: Icon(
                  Icons.filter_alt,
                  size: 30, // Increase the size of the icon
                  color: Colors.white, // Change the color to white
                ),
                onPressed: () {
                  _showFilterPopup(context);
                },
              ),
            ],
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

  // void _showFilterPopup(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Filter by Date'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ElevatedButton(
  //               onPressed: () async {
  //                 final DateTime? picked = await showDatePicker(
  //                   context: context,
  //                   initialDate: DateTime.now(),
  //                   firstDate: DateTime(2000),
  //                   lastDate: DateTime(2101),
  //                 );
  //                 if (picked != null && picked != selectedDate) {
  //                   setState(() {
  //                     selectedDate = picked;
  //                   });
  //                 }
  //               },
  //               child: Text(selectedDate == null ? 'Select Date' : 'Change Date'),
  //             ),
  //             SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Add your filter functionality here
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('Apply Now'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }


  void _showFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter by Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
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
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40), // Adjust padding as needed
                ),
                child: Text(
                  selectedDate == null ? 'Select Date' : 'Change Date',
                  style: TextStyle(fontSize: 18), // Increase text size
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your filter functionality here
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 40), // Adjust padding as needed
                ),
                child: Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 18), // Increase text size
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}
