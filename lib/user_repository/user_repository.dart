import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/personal_information.dart';
import '../models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    log("----createUser----");
    log("----createUser1111---- $user");
    await _db.collection("Users").add(user.toJson()).then(
          (value) {
        Get.snackbar(
          "Success",
          "Your account has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      },
      onError: (error, stackTrace) {
        Get.snackbar(
          "Error",
          "Something Went Wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
        print(error.toString());
      },
    );
  }


  createProfile(InfoModel profile) async {
    log("----createProfile----");
    log("----createProfile1111---- $profile");
    await _db.collection("Profile").add(profile.toJson()).then(
          (value) {
        Get.snackbar(
          "Success",
          "Your Profile has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      },
      onError: (error, stackTrace) {
        Get.snackbar(
          "Error",
          "Something Went Wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
        print(error.toString());
      },
    );
  }

  createEducation(educationModel education) async {
    log("----createEducation----");
    log("----createEducation1111---- $education");
    await _db.collection("education").add(education.toJson()).then(
          (value) {
        Get.snackbar(
          "Success",
          "Your Education has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      },
      onError: (error, stackTrace) {
        Get.snackbar(
          "Error",
          "Something Went Wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
        print(error.toString());
      },
    );
  }


postJob(postjobModel job) async {
  log("----postJob----");
  log("----postJob1111---- $job");
  await _db.collection("job").add(job.toJson()).then(
        (value) {
      Get.snackbar(
        "Success",
        "Your Job has been Posted.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    },
    onError: (error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something Went Wrong.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    },
  );
}
}
