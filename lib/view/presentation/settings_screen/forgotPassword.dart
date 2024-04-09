import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';

class ForgotPasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ForgotPasswordForm(),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _newPasswordController,
            decoration: InputDecoration(labelText: 'New Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your new password';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                child: Icon(
                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !_isConfirmPasswordVisible, // Toggle password visibility
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              } else if (value != _newPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          SizedBox(height: 50.0),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Reset Password",
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      height: 50.0,
      width: 200.0,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // Check if new password and confirm password match
          if (_newPasswordController.text != _confirmPasswordController.text) {
            // If passwords don't match, show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Passwords do not match'),
              ),
            );
            return; // Return to prevent further execution
          }
          // Passwords match, proceed with password reset logic
          _resetPassword(_newPasswordController.text,_confirmPasswordController.text);
        }
      },
    );
  }



  void _resetPassword(String newPassword, String password) async {
    try {
      // Get the user's ID if they are logged in
      String? userId;
      if (FirebaseAuth.instance.currentUser != null) {
        userId = FirebaseAuth.instance.currentUser!.uid;
      }

      // Update the password in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'password': password,
        'npassword': newPassword,
        // Assuming the field in Firestore is 'password'
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset successfully'),
        ),
      );

      // Redirect to the previous page after a short delay
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context, AppRoutes.settingsScreen); // Return to the previous page
      });
    } catch (error) {
      // Show error message if password reset fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reset password: $error'),
        ),
      );
    }
  }


}
