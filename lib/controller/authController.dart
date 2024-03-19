import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/presentation/home_container_screen/home_container_screen.dart';
import 'package:saumil_s_application/presentation/job_type_screen/job_type_screen.dart';
import 'package:saumil_s_application/presentation/sign_up_complete_account_screen/sign_up_complete_account_screen.dart';

import '../models/user_model.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/sign_up_create_acount_screen/sign_up_create_acount_screen.dart';
import '../user_repository/user_repository.dart';
import '../util/colors.dart';
import '../util/common_methos.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';

// import '../pages/home_screen.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final userRepo = Get.put(UserRepository());

  Future clearForm() async {
    emailController.clear();
    passwordController.clear();
    passwordController.clear();
  }


  String? getLoggedInUserEmail() {
    User? user = _auth.currentUser;
    return user?.email;
  }


  // Future<void> saveProfileInfo(InfoModel profile) async {
  //
  //     saveProfileInfo(firstname : firstNameController.text, lastname : lastNameController.text,
  //   email : emailController.text, phoneno : phoneController.text, address:locationController.text);
  //   userRepo.createProfile(profile);
  // }




  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        User user = userCredential.user!;
        // Send email verification
        await userCredential.user!.sendEmailVerification().whenComplete(() async {
          // Save user details and registration datetime
          await saveUserDetails(UserModel(
              id: user.uid.toString(),
              email: user.email.toString().trim(),
              password: passwordController.text));
          // Show success message
          await CommonMethod()
              .getXSnackBar(
            "Success",
            'Verification email sent to ${userCredential.user!.email}',
            Colors.green,
          )
              .then((value) => Get.to(() => LoginScreen()));
        });
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific error cases
      if (e.code == 'email-already-in-use') {
        await CommonMethod().getXSnackBar(
          "Error",
          'The email address is already in use. Please use a different email.',
          Colors.red,
        );
      } else if (e.code == 'weak-password') {
        await CommonMethod().getXSnackBar(
          "Error",
          'The password provided is too weak. Please choose a stronger password.',
          Colors.red,
        );
      } else {
        // Handle other authentication errors
        await CommonMethod().getXSnackBar(
          "Error",
          'Failed to register: ${e.message}',
          Colors.red,
        );
      }
    }
  }

  Future<void> saveUserDetails(UserModel userModel) async {
    // Check if the user already exists in Firestore
    final userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel.id)
        .get();

    // If the user doesn't exist, save the user details with registration datetime
    if (!userSnapshot.exists) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userModel.id)
          .set({
        'email': userModel.email,
        'password': userModel.password,
        'registrationDateTime': DateTime.now().toString(), // Store registration datetime
      });
    }
  }

  // Sign in with email and password
  Future<String?>   signInWithEmailAndPassword(BuildContext context) async {
    // try {
    print("----${emailController.text}");
    print("----${passwordController.text}");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim().toString(),
          password: passwordController.text);

      if (userCredential.user!.emailVerified) {
        // User is signed in and email is verified
        await CommonMethod()
            .getXSnackBar("Success", 'Sign-in successfully', success)
            .whenComplete(() => Get.to(() => JobTypeScreen()));
      } else {
        // Email is not verified, handle accordingly
        await CommonMethod().getXSnackBar(
            "Error",
            'Email not verified. Check your inbox for the verification email.',
            red);
        print('');
      }
    // } on FirebaseAuthException catch (e) {
    //   print("---->>>>>>${e}");
    //   await CommonMethod()
    //       .getXSnackBar("Error", 'Failed to sign in: ${e.message}', red);
    // }
    return null;
  }




  // Register with email and password
  // Future<void> registerWithEmailAndPassword(BuildContext context) async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text,
  //     );
  //
  //     if (userCredential.user != null) {
  //       User user = userCredential.user!;
  //       // Send email verification
  //       await userCredential.user!.sendEmailVerification().whenComplete(
  //           () async => saveUserDetails(UserModel(
  //               id: user.uid.toString(),
  //               email: user.email.toString().trim(),
  //               password: passwordController.text)));
  //
  //       await CommonMethod()
  //           .getXSnackBar(
  //             "Success",
  //             'Verification email sent to ${userCredential.user!.email}',
  //             Colors.green,
  //           )
  //           .then((value) => Get.to(() => LoginScreen()));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Handle specific error cases
  //     if (e.code == 'email-already-in-use') {
  //       await CommonMethod().getXSnackBar(
  //         "Error",
  //         'The email address is already in use. Please use a different email.',
  //         Colors.red,
  //       );
  //     } else if (e.code == 'weak-password') {
  //       await CommonMethod().getXSnackBar(
  //         "Error",
  //         'The password provided is too weak. Please choose a stronger password.',
  //         Colors.red,
  //       );
  //     } else {
  //       // Handle other authentication errors
  //       await CommonMethod().getXSnackBar(
  //         "Error",
  //         'Failed to register: ${e.message}',
  //         Colors.red,
  //       );
  //     }
  //   }
  // }
  //
  // Future saveUserDetails(UserModel user) async {
  //   userRepo.createUser(user);
  //   // controller.registerWithEmailAndPassword(context);
  // }
  //
  // // Sign in with email and password
  // Future<String?> signInWithEmailAndPassword(BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: emailController.text.trim().toString(),
  //         password: passwordController.text);
  //
  //     if (userCredential.user!.emailVerified) {
  //       // User is signed in and email is verified
  //       await CommonMethod()
  //           .getXSnackBar("Success", 'Sign-in successfully', success)
  //           .whenComplete(() => Get.to(() => JobTypeScreen()));
  //     } else {
  //       // Email is not verified, handle accordingly
  //       await CommonMethod().getXSnackBar(
  //           "Error",
  //           'Email not verified. Check your inbox for the verification email.',
  //           red);
  //       print('');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     await CommonMethod()
  //         .getXSnackBar("Error", 'Failed to sign in: ${e.message}', red);
  //   }
  // }
  //


// Sign in with Google
  Future<User?> handleSignInGoogle() async {
    try {
      await googleSignIn.signOut(); // Sign out to allow multiple account selection
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // User canceled Google Sign-In
        await CommonMethod().getXSnackBar(
            "Info", 'Google Sign-In canceled by user', red);
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
      await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // Successfully signed in with Google
        await CommonMethod().getXSnackBar(
            "Success", 'Signed in: ${user.displayName}', success);

        // Check if the user is signing in for the first time
        final isFirstSignIn = await checkFirstSignIn(user.uid);

        if (isFirstSignIn) {
          // If it's the first sign-in, store the current datetime in Firestore
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .set({'registrationDateTime': DateTime.now().toString()}, SetOptions(merge: true));
        }

        // Navigate to JobTypeScreen after signing in
        await Get.to(() => JobTypeScreen());
      }

      return user;
    } catch (error) {
      // Handle specific error cases
      if (error is FirebaseAuthException) {
        await CommonMethod().getXSnackBar(
            "Error", 'Firebase Auth Error: ${error.message}', red);
      } else {
        // Handle other errors
        await CommonMethod().getXSnackBar(
            "Error", 'Error signing in with Google: $error', red);
        log("----errorGoogle--->> " + error.toString());
      }
      return null;
    }
  }

// Function to check if it's the first sign-in for the user
  Future<bool> checkFirstSignIn(String userId) async {
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get();

    return !userData.exists;
  }


  // // Sign in with Google
  // Future<User?> handleSignInGoogle() async {
  //   try {
  //     await googleSignIn
  //         .signOut(); // Sign out to allow multiple account selection
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //
  //     if (googleSignInAccount == null) {
  //       // User canceled Google Sign-In
  //       await CommonMethod()
  //           .getXSnackBar("Info", 'Google Sign-In canceled by user', red);
  //       return null;
  //     }
  //
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     final UserCredential authResult =
  //         await _auth.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //
  //     if (user != null) {
  //       // Successfully signed in with Google
  //       await CommonMethod()
  //           .getXSnackBar("Success", 'Signed in: ${user.displayName}', success)
  //           .whenComplete(() => Get.to(() => JobTypeScreen()));
  //     }
  //
  //     return user;
  //   } catch (error) {
  //     // Handle specific error cases
  //     if (error is FirebaseAuthException) {
  //       await CommonMethod().getXSnackBar(
  //           "Error", 'Firebase Auth Error: ${error.message}', red);
  //     } else {
  //       // Handle other errors
  //       await CommonMethod()
  //           .getXSnackBar("Error", 'Error signing in with Google: $error', red);
  //       log("----errorGoogle--->> " + error.toString());
  //     }
  //     return null;
  //   }
  // }

  // Check if the user is currently signed in
  Future<bool> isUserSignedIn() async {
    return _auth.currentUser != null;
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => SignUpCreateAcountScreen());
    } catch (e) {
      CommonMethod().getXSnackBar("Error", 'Error signing out: $e', red);
    }
  }

  Future<User?> getCurrentUser() async {
    User? user = await _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      print('-----Current User ID: $userId');
      return user;
    } else {
      print('----User is not signed in.');
    }
    return null;
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // User document exists, create a UserModel instance
        UserModel userData =
        UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
        return userData;
      } else {
        // User document doesn't exist
        return null;
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      return null;
    }
  }
}