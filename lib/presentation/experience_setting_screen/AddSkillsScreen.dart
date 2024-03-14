import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saumil_s_application/presentation/experience_setting_screen/experience_setting_screen.dart'; // Import Firebase Authentication

class AddSkillsScreen extends StatefulWidget {
  @override
  _AddSkillsScreenState createState() => _AddSkillsScreenState();
}

class _AddSkillsScreenState extends State<AddSkillsScreen> {
  List<String> _selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Skills'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _skillsList.length,
              itemBuilder: (context, index) {
                final skill = _skillsList[index];
                return CheckboxListTile(
                  title: Text(skill),
                  value: _selectedSkills.contains(skill),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedSkills.add(skill);
                      } else {
                        _selectedSkills.remove(skill);
                      }
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                _addSkillsToCurrentUser(_selectedSkills); // Call function to add skills to Firestore
              },
              style: ElevatedButton.styleFrom(
                // primary: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).primaryColor,
                fixedSize: Size.fromHeight(50),
              ),
              child: Text(
                'Add Skills',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Function to add skills to Firestore under the current user's document
  Future<void> _addSkillsToCurrentUser(List<String> skills) async {
    try {
      // Get reference to the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get reference to the Firestore collection
        CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

        // Reference to the current user's document
        DocumentReference userDocRef = usersCollection.doc(user.uid);

        // Add the selected skills to the current user's document
        await userDocRef.update({
          'skills': FieldValue.arrayUnion(skills), // Add skills to an array field
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Skills added successfully'),
          ),
        );

        // Redirect to the experience screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExperienceSettingScreen()), // Replace ExperienceScreen with your actual screen
        );
      } else {
        // Show a message if user is not logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not logged in'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add skills: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  final List<String> _skillsList = [
    'HTML',
    'CSS',
    'JavaScript',
    'Python',
    'Java',
    'C',
    'C++',
    'PHP',
    'Flutter',
    'Node JS',
    'React Native',
    'Kotlin/Java(Android)',
    'Swift(IOS)',
    'MySQL',
  ];
}
