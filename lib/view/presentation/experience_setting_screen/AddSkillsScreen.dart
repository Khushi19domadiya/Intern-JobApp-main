import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_app/view/presentation/profile_page/profile_page.dart';

class AddSkillsScreen extends StatefulWidget {
  @override
  _AddSkillsScreenState createState() => _AddSkillsScreenState();
}

class _AddSkillsScreenState extends State<AddSkillsScreen> {
  List<String> _selectedSkills = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserSkills();
  }

  Future<void> _fetchUserSkills() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          List<dynamic> userSkills = userDoc['skills'] ?? [];
          setState(() {
            _selectedSkills = List<String>.from(userSkills);
          });
        }
      }
    } catch (e) {
      print('Failed to fetch user skills: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Skills'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                        _removeSkillsFromCurrentUser([skill]);
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
                _addSkillsToCurrentUser(_selectedSkills);
              },
              style: ElevatedButton.styleFrom(
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

  Future<void> _addSkillsToCurrentUser(List<String> skills) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
        DocumentReference userDocRef = usersCollection.doc(user.uid);

        await userDocRef.update({
          'skills': FieldValue.arrayUnion(skills),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Skills added successfully'),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not logged in'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add skills: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _removeSkillsFromCurrentUser(List<String> skills) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
        DocumentReference userDocRef = usersCollection.doc(user.uid);

        await userDocRef.update({
          'skills': FieldValue.arrayRemove(skills),
        });
      }
    } catch (e) {
      print('Failed to remove skills: $e');
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
