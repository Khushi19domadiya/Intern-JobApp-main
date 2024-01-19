// class InfoModel  {
//   final String? id;
//   final String firstname;
//   final String lastname;
//   final String email;
//   final int phoneno;
//   final String address;
//
//   InfoModel({
//     this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.phoneno,
//     required this.address,
//   });
//   toJson(){
//     return{
//       "id":id,
//       "First Name":  firstname,
//       "Last Name" : lastname,
//       "Email": email,
//       "Phone No." : phoneno,
//       "Adress": address,
//     };
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadImage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() => print('Image Uploaded'));

      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(File(imagePath));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<String> saveDate({
    // void int id,
    required String fname,
    required String lname,
    required String email,
    required String phonenumber,
    required String address,
    required File file,
  }) async {
    log("----saveProfileCalledInside-----");

    String resp = " Some Error Occurred";
    // try{
    if (fname.isNotEmpty ||
        lname.isNotEmpty ||
        email.isNotEmpty ||
        phonenumber.isNotEmpty ||
        address.isNotEmpty) {
      log("----file-----");
      log("----file-----${file.path}");
      // String imageUrl = await uploadImageToStorage('profileImage', file);
      // log("----imageUrl-----${imageUrl}");
      String imageUrl = await uploadImageToFirebaseStorage(file.path);
      log("----imageUrl-----${imageUrl}");

      await _firestore.collection('userProfile').add({
        // 'id': id,
        'fname': fname,
        'lname': lname,
        'email': email,
        'phonenumber': phonenumber,
        'address': address,
        'imageLink': imageUrl,
      });
      log("----collection-----}");

      resp = 'Success';
      // }
      // }
      // catch(err){
      //   resp = err.toString();
    }
    return resp;
  }
}
