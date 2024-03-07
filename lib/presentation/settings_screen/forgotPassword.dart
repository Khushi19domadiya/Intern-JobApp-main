import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

import '../../widgets/custom_elevated_button.dart';

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
            decoration: InputDecoration(labelText: 'Confirm Password'),
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
      margin: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal margin
      height: 50.0,
      width: 200.0,// Set desired height
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // Submit the form
          // You can add your logic to handle password reset here
          // For example, call a function to reset the password
          _resetPassword(_newPasswordController.text);
        }
      },
    );
  }

  void _resetPassword(String newPassword) {
    // Add your logic here to reset the password
    // For example, you can call the Firebase Auth API to reset the password
  }
}
